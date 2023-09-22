//
//  HTTPClient.swift
//  Essential Feed
//
//  Created by Zoltan Damo on 2023. 09. 22..
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
