//
//  XCTestCase+MemoryLeakTracking.swift
//  Essential FeedTests
//
//  Created by Zoltan Damo on 2023. 09. 26..
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
