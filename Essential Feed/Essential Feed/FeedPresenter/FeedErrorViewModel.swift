//
//  FeedErrorViewModel.swift
//  Essential Feed
//
//  Created by Zoltan Damo on 17/12/2023.
//

import Foundation

public struct FeedErrorViewModel {
    public let message: String?

    static var noError: FeedErrorViewModel {
        return FeedErrorViewModel(message: nil)
    }

    static func error(message: String) -> FeedErrorViewModel {
        return FeedErrorViewModel(message: message)
    }
}
