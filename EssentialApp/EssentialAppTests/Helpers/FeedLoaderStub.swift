//
//  FeedLoaderStub.swift
//  EssentialAppTests
//
//  Created by Zoltan Damo on 02.01.2024.
//

import Foundation

import EssentialFeed

class FeedLoaderStub: FeedLoader {
    private let result: FeedLoader.Result
    
    init(result: FeedLoader.Result) {
        self.result = result
    }
    
    func load(completion: @escaping (FeedLoader.Result) -> Void) {
        completion(result)
    }
}
