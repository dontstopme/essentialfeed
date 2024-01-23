//
//  FeedCache.swift
//  EssentialFeed
//
//  Created by Zoltan Damo on 03.01.2024.
//

import Foundation

public protocol FeedCache {
    func save(_ feed: [FeedImage]) throws
}
