//
//  FeedLoader.swift
//  Essential Feed
//
//  Created by Zoltan Damo on 2023. 09. 08..
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
