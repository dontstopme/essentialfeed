//
//  FeedLoader.swift
//  Essential Feed
//
//  Created by Zoltan Damo on 2023. 09. 08..
//

import Foundation

public protocol FeedLoader {
    typealias Result = Swift.Result<[FeedImage], Error>

    func load(completion: @escaping (Result) -> Void)
}
