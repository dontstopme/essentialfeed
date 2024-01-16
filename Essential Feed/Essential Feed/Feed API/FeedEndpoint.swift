//
//  FeedEndpoint.swift
//  EssentialFeed
//
//  Created by Zoltan Damo on 16.01.2024.
//

import Foundation

public enum FeedEndpoint {
    case get
    
    public func url(baseURL: URL) -> URL {
        switch self {
        case .get:
            return baseURL.appendingPathComponent("/v1/feed")
        }
    }
}
