//
//  UIRefreshControl+Helpers.swift
//  EssentialFeediOS
//
//  Created by Zoltan Damo on 15.01.2024.
//

import UIKit

extension UIRefreshControl {
	func update(isRefreshing: Bool) {
		isRefreshing ? beginRefreshing() : endRefreshing()
	}
}
