//
//  FeedLoader.swift
//  Essential Feed
//
//  Created by Zoltan Damo on 2023. 09. 08..
//

import Foundation

public typealias LoadFeedResult = Result<[FeedImage], Error>

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
