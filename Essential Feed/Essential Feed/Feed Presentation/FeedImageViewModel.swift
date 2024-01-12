//
//  FeedImageViewModel.swift
//  Essential Feed
//
//  Created by Zoltan Damo on 17/12/2023.
//

import Foundation

public struct FeedImageViewModel {
    public let description: String?
    public let location: String?

    public var hasLocation: Bool {
        return location != nil
    }
}
