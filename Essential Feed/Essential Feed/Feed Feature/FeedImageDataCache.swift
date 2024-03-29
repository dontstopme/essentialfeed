//
//  FeedImageDataCache.swift
//  EssentialFeed
//
//  Created by Zoltan Damo on 04.01.2024.
//

import Foundation

public protocol FeedImageDataCache {
    typealias Result = Swift.Result<Void, Error>
    
    func save(_ data: Data, for url: URL) throws
}
