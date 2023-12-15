//
//  FeedRefreshController.swift
//  EssentialFeediOS
//
//  Created by Zoltan Damo on 10/12/2023.
//

import UIKit

protocol FeedRefreshViewControllerDelegate {
    func didRequestFeedRefresh()
}

public final class FeedRefreshViewController: NSObject, FeedLoadingView {
   private(set) lazy var view = loadView()

    private let delegate: FeedRefreshViewControllerDelegate

    public var refreshInit: ()->UIRefreshControl = UIRefreshControl.init

    init(delegate: FeedRefreshViewControllerDelegate) {
        self.delegate = delegate
	}

	@objc func refresh() {
        self.delegate.didRequestFeedRefresh()
	}

    func display(_ viewModel: FeedLoadingViewModel) {
        if viewModel.isLoading {
            view.beginRefreshing()
        } else {
            view.endRefreshing()
        }
    }

    private func loadView() -> UIRefreshControl {
        let view = refreshInit()
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)

        return view
    }
}
