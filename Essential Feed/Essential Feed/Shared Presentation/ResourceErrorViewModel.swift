//
//  ResourceErrorViewModel.swift
//  EssentialFeed
//
//  Created by Zoltan Damo on 12.01.2024.
//

import Foundation

public struct ResourceErrorViewModel {
    public let message: String?

    static var noError: ResourceErrorViewModel {
        return ResourceErrorViewModel(message: nil)
    }

    static func error(message: String) -> ResourceErrorViewModel {
        return ResourceErrorViewModel(message: message)
    }
}
