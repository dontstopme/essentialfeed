//
//  SharedLocalizationTests.swift
//  Essential FeedTests
//
//  Created by Zoltan Damo on 11.01.2024.
//

import XCTest
import EssentialFeed

class SharedLocalizationTests: XCTestCase {

    func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
        let table = "Shared"
        let bundle = Bundle(for: LoadResourcePresenter<Any, DummyView>.self)

        assertLocalizedKeyAndValuesExist(in: bundle, table)
    }

    private class DummyView: ResourceView {
        func display(_ viewModel: Any) {}
    }
}
