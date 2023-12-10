//
//  UIRefreshControl+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Zoltan Damo on 10/12/2023.
//

import UIKit

class FakeRefreshControl: UIRefreshControl {
    var _isRefreshing = false

    override var isRefreshing: Bool { _isRefreshing }

    override func beginRefreshing() {
         _isRefreshing = true
    }

    override func endRefreshing() {
        _isRefreshing = false
    }
}

extension UIRefreshControl {
    func simulatePullToRefresh() {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: .valueChanged)?.forEach {
                (target as NSObject).perform(Selector($0))
            }
        }
    }
}
