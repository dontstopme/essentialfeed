//
//  FeedImageDataStore.swift
//  Essential Feed
//
//  Created by Zoltan Damo on 27/12/2023.
//

import Foundation

public protocol FeedImageDataStore {
    func insert(_ data: Data, for url: URL) throws

    func retrieve(dataForURL url: URL) throws -> Data?
}
