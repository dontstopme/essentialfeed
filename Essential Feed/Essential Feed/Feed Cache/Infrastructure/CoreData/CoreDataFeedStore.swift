//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import CoreData

public final class CoreDataFeedStore: FeedStore {
    private static let modelName = "FeedStore"
    private static let model = NSManagedObjectModel.with(name: modelName, in: Bundle(for: CoreDataFeedStore.self))

	private let container: NSPersistentContainer
	private let context: NSManagedObjectContext

    enum StoreError: Swift.Error {
        case modelNotFound
        case failedToLoadPersistentContainer(Swift.Error)
    }

	public init(storeURL: URL, bundle: Bundle = .main) throws {
        guard let model = CoreDataFeedStore.model else {
 			throw StoreError.modelNotFound
 		}

        do {
            container = try NSPersistentContainer.load(modelName: CoreDataFeedStore.modelName, model: model, url: storeURL)
            context = container.newBackgroundContext()
        } catch {
            throw StoreError.failedToLoadPersistentContainer(error)
        }
	}

	public func retrieve(completion: @escaping RetrievalCompletion) {
		perform { context in
            completion(Result {
 				try ManagedCache.find(in: context).map {
                    return CachedFeed(feed: $0.localFeed, timestamp: $0.timestamp)
 				}
 			})
		}
	}
	
	public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
		perform { context in
			completion(Result {
 				let managedCache = try ManagedCache.newUniqueInstance(in: context)
 				managedCache.timestamp = timestamp
 				managedCache.feed = ManagedFeedImage.images(from: feed, in: context)
 				try context.save()
 			})
		}
	}

	public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
		perform { context in
			completion(Result {
 				try ManagedCache.find(in: context).map(context.delete).map(context.save)
 			})
		}
	}

	private func perform(_ action: @escaping (NSManagedObjectContext) -> Void) {
		let context = self.context
		context.perform { action(context) }
	}
}
