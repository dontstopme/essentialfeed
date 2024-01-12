//
//  FeedLocalizationTests.swift
//  EssentialFeediOSTests
//
//  Created by Zoltan Damo on 16/12/2023.
//

import Foundation
import EssentialFeed

import XCTest
 @testable import EssentialFeediOS

 final class FeedLocalizationTests: XCTestCase {

     func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
         let table = "Feed"
         let bundle = Bundle(for: FeedPresenter.self)

         assertLocalizedKeyAndValuesExist(in: bundle, table)
     }
 }
