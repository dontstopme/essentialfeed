//
//  EssentialFeedViewController.swift
//  EssentialFeediOS
//
//  Created by Zoltan Damo on 05/12/2023.
//

import UIKit

public final class FeedViewController: UITableViewController, UITableViewDataSourcePrefetching {
    public var refreshController: FeedRefreshViewController?
    private var imageLoader: FeedImageDataLoader?
    var tableModel = [FeedImageCellController]() {
        didSet { tableView.reloadData() }
    }

    private var onViewIsAppearing: ((FeedRefreshViewController?, FeedViewController) -> Void)?

    public convenience init(refreshController: FeedRefreshViewController) {
        self.init()

        self.refreshController = refreshController
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        tableView.prefetchDataSource = self
        refreshControl = refreshController?.view

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
        cancelCellControllerLoad(forRowAt: indexPath)
 	}

    public override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellController(forRowAt: indexPath).preload()
    }

    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
 		indexPaths.forEach { indexPath in
            cellController(forRowAt: indexPath).preload()
 		}
 	}

    public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
 		indexPaths.forEach(cancelCellControllerLoad)
 	}

    // MARK: - Helpers

    private func cellController(forRowAt indexPath: IndexPath) -> FeedImageCellController {
        return tableModel[indexPath.row]
    }

    private func cancelCellControllerLoad(forRowAt indexPath: IndexPath) {
        cellController(forRowAt: indexPath).cancelLoad()
    }
}
