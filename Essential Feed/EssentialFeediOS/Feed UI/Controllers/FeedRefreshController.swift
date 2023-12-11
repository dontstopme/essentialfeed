//
//  FeedRefreshController.swift
//  EssentialFeediOS
//
//  Created by Zoltan Damo on 10/12/2023.
//

import UIKit
import Essential_Feed

public final class FeedRefreshViewController: NSObject {
    public var view: UIRefreshControl = UIRefreshControl()

	private let feedLoader: FeedLoader

	init(feedLoader: FeedLoader) {
		self.feedLoader = feedLoader

        super.init()
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
	}

	var onRefresh: (([FeedImage]) -> Void)?

	@objc func refresh() {
		view.beginRefreshing()
		feedLoader.load { [weak self] result in
			if let feed = try? result.get() {
				self?.onRefresh?(feed)
			}
			self?.view.endRefreshing()
		}
	}
}
