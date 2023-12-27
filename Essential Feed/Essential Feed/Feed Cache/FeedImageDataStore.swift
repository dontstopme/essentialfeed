//
//  FeedImageDataStore.swift
//  Essential Feed
//
//  Created by Zoltan Damo on 27/12/2023.
//

import Foundation

public protocol FeedImageDataStore {
    typealias Result = Swift.Result<Data?, Error>

    func retrieve(dataForURL url: URL, completion: @escaping (Result) -> Void)
}
