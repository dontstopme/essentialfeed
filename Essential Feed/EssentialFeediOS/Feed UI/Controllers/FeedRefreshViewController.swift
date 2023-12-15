//
//  FeedRefreshController.swift
//  EssentialFeediOS
//
//  Created by Zoltan Damo on 10/12/2023.
//

import UIKit

public final class FeedRefreshViewController: NSObject, FeedLoadingView {
   private(set) lazy var view = loadView()

    private let presenter: FeedPresenter

    public var refreshInit: ()->UIRefreshControl = UIRefreshControl.init

    init(presenter: FeedPresenter) {
        self.presenter = presenter
	}

	@objc func refresh() {
        presenter.loadFeed()
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
