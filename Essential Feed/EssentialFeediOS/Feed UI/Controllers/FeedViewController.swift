//
//  EssentialFeedViewController.swift
//  EssentialFeediOS
//
//  Created by Zoltan Damo on 05/12/2023.
//

import UIKit
import Essential_Feed

public final class FeedViewController: UITableViewController, UITableViewDataSourcePrefetching {
    public var refreshController: FeedRefreshViewController?
    private var imageLoader: FeedImageDataLoader?
    private var tableModel = [FeedImage]() {
        didSet { tableView.reloadData() }
    }
    private var cellControllers = [IndexPath: FeedImageCellController]()

    private var onViewIsAppearing: ((FeedRefreshViewController?, FeedViewController) -> Void)?

    public convenience init(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) {
        self.init()

        self.refreshController = FeedRefreshViewController(feedLoader: feedLoader)
        self.imageLoader = imageLoader
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl = refreshController?.view
        refreshController?.onRefresh = { [weak self] feed in
            self?.tableModel = feed
        }

        tableView.prefetchDataSource = self

        onViewIsAppearing = { refreshController, feedViewController in
            refreshController?.refresh()

            feedViewController.onViewIsAppearing = nil
        }


    }

    public override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)

        onViewIsAppearing?(refreshController, self)
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 		return tableModel.count
 	}

 	public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellController(forRowAt: indexPath).view()
 	}

    public override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        removeCellController(forRowAt: indexPath)
 	}

    public override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cellControllers[indexPath] == nil {
            cellControllers[indexPath] = cellController(forRowAt: indexPath)
        }

        cellControllers[indexPath]?.preload()
    }

    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
 		indexPaths.forEach { indexPath in
            cellController(forRowAt: indexPath).preload()
 		}
 	}

    public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
 		indexPaths.forEach(removeCellController)
 	}

    // MARK: - Helpers

    private func cellController(forRowAt indexPath: IndexPath) -> FeedImageCellController {
        let cellModel = tableModel[indexPath.row]
 		let cellController = FeedImageCellController(model: cellModel, imageLoader: imageLoader!)
 		cellControllers[indexPath] = cellController

        return cellController
    }

    private func removeCellController(forRowAt indexPath: IndexPath) {
        cellControllers[indexPath] = nil
    }

//    private func startTask(forRowAt indexPath: IndexPath, in cell: UITableViewCell?) {
//        guard let cell = cell as? FeedImageCell else { return }
//        cell.feedImageContainer.startShimmering()
//        let cellModel = tableModel[indexPath.row]
//
//        tasks[indexPath] = imageLoader?.loadImageData(from: cellModel.url) { [weak cell] result in
//            let data = try? result.get()
//            let image = data.map(UIImage.init) ?? nil
// 			cell?.feedImageView.image = image
// 			cell?.feedImageRetryButton.isHidden = (image != nil)
//            cell?.feedImageContainer.stopShimmering()
//         }
//    }
}
