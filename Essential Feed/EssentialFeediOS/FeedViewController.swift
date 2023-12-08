//
//  EssentialFeedViewController.swift
//  EssentialFeediOS
//
//  Created by Zoltan Damo on 05/12/2023.
//

import UIKit
import Essential_Feed

public protocol FeedImageDataLoaderTask {
 	func cancel()
}

public protocol FeedImageDataLoader {
    typealias Result = Swift.Result<Data, Error>

    func loadImageData(from url: URL, completion: @escaping (Result) -> Void) -> FeedImageDataLoaderTask
}

final public class FeedViewController: UITableViewController {
    private var feedLoader: FeedLoader?
    private var imageLoader: FeedImageDataLoader?
    private var tableModel = [FeedImage]()
    private var tasks = [IndexPath: FeedImageDataLoaderTask]()

    private var onViewIsAppearing: ((FeedViewController) -> Void)?

    public convenience init(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) {
        self.init()

        self.feedLoader = feedLoader
        self.imageLoader = imageLoader
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(load), for: .valueChanged)

        onViewIsAppearing = { feedViewController in
            feedViewController.load()
            feedViewController.onViewIsAppearing = nil
        }
    }

    public override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)

        onViewIsAppearing?(self)
    }

    @objc private func load() {
        refreshControl?.beginRefreshing()
        feedLoader?.load { [weak self] result in
            self?.tableModel = (try? result.get()) ?? []
 			self?.tableView.reloadData()
            self?.refreshControl?.endRefreshing()
        }
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 		return tableModel.count
 	}

 	public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 		let cellModel = tableModel[indexPath.row]
 		let cell = FeedImageCell()
 		cell.locationContainer.isHidden = (cellModel.location == nil)
 		cell.locationLabel.text = cellModel.location
 		cell.descriptionLabel.text = cellModel.description
        cell.feedImageView.image = nil
        cell.feedImageRetryButton.isHidden = true

        startTask(forRowAt: indexPath, in: cell)

 		return cell
 	}

    public override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cancelTask(forRowAt: indexPath)
 	}

    public override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if let cell = cell as? FeedImageCell {
            startTask(forRowAt: indexPath, in: cell)
        }
    }


    private func cancelTask(forRowAt indexPath: IndexPath) {
        tasks[indexPath]?.cancel()
        tasks[indexPath] = nil
    }

    private func startTask(forRowAt indexPath: IndexPath, in cell: FeedImageCell) {
        cell.feedImageContainer.startShimmering()
        let cellModel = tableModel[indexPath.row]

        tasks[indexPath] = imageLoader?.loadImageData(from: cellModel.url) { [weak cell] result in
            let data = try? result.get()
            cell?.feedImageView.image = data.map(UIImage.init) ?? nil
            cell?.feedImageRetryButton.isHidden = (data != nil)
            cell?.feedImageContainer.stopShimmering()
         }
    }
}
