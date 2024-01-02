//
//  SharedTestHelpers.swift
//  EssentialAppTests
//
//  Created by Zoltan Damo on 02.01.2024.
//

import Foundation

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    return URL(string: "http://any-url.com")!
}

func anyData() -> Data {
    return Data("any data".utf8)
}
