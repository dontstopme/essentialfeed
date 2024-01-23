//
//  FeedImageDataLoader.swift
//  EssentialFeediOS
//
//  Created by Zoltan Damo on 10/12/2023.
//

import Foundation

public protocol FeedImageDataLoader {
    func loadImageData(from url: URL) throws -> Data
}
