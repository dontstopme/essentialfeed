//
//  FeedCache.swift
//  EssentialFeed
//
//  Created by Zoltan Damo on 03.01.2024.
//

import Foundation

public protocol FeedCache {
    typealias Result = Swift.Result<Void, Error>
    
    func save(_ feed: [FeedImage], completion: @escaping (Result) -> Void)
}
