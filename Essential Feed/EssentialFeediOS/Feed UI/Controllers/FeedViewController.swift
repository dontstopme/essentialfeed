//
//  EssentialFeedViewController.swift
//  EssentialFeediOS
//
//  Created by Zoltan Damo on 05/12/2023.
//

import UIKit
import EssentialFeed

public protocol FeedViewControllerDelegate {
    func didRequestFeedRefresh()
}

public final class FeedViewController: UITableViewController, UITableViewDataSourcePrefetching, FeedLoadingView, FeedErrorView {
    public var delegate: FeedViewControllerDelegate?
    @IBOutlet private(set) public var errorView: ErrorView?

    private var tableModel = [FeedImageCellController]() {
        didSet { tableView.reloadData() }
    }

    private var onViewIsAppearing: ((FeedViewController) -> Void)?

    public override func viewDidLoad() {
        super.viewDidLoad()

        onViewIsAppearing = { feedViewController in
            feedViewController.delegate?.didRequestFeedRefresh()

            feedViewController.onViewIsAppearing = nil
        }
    }

    public override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)

        onViewIsAppearing?(self)
    }

    @IBAction private func refresh() {
        delegate?.didRequestFeedRefresh()
    }

    public func display(_ cellControllers: [FeedImageCellController]) {
 		tableModel = cellControllers
 	}

    public func display(_ viewModel: FeedLoadingViewModel) {
        if viewModel.isLoading {
            refreshControl?.beginRefreshing()
        } else {
            refreshControl?.endRefreshing()
        }
    }

    public func display(_ viewModel: FeedErrorViewModel) {
        errorView?.message = viewModel.message
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 		return tableModel.count
 	}

 	public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellController(forRowAt: indexPath).view(in: tableView)
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
