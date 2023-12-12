//
//  FeedRefreshController.swift
//  EssentialFeediOS
//
//  Created by Zoltan Damo on 10/12/2023.
//

import UIKit

public final class FeedRefreshViewController: NSObject {
    private lazy var _view: UIRefreshControl = binded(UIRefreshControl())

    public var view: UIRefreshControl {
        get {
            return _view
        }

        set {
            unbind(_view)
            _view = binded(newValue)
        }
    }



	private let viewModel: FeedViewModel

    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
	}

	@objc func refresh() {
        viewModel.loadFeed()
	}

    private func binded(_ view: UIRefreshControl) -> UIRefreshControl {
        viewModel.onChange = { [weak self] viewModel in
            if viewModel.isLoading {
                self?.view.beginRefreshing()
            } else {
                self?.view.endRefreshing()
            }
        }

        view.addTarget(self, action: #selector(refresh), for: .valueChanged)

        return view
    }

    private func unbind(_ view: UIRefreshControl) {
        view.removeTarget(self, action: #selector(refresh), for: .valueChanged)
    }
}
