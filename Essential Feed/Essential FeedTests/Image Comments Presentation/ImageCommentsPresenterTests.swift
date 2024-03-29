//
//  ImageCommentsPresenterTests.swift
//  Essential FeedTests
//
//  Created by Zoltan Damo on 12.01.2024.
//

import XCTest
import EssentialFeed

final class ImageCommentsPresenterTests: XCTestCase {

    func test_title_isLocalized() {
        XCTAssertEqual(ImageCommentsPresenter.title, localized("IMAGE_COMMENTS_VIEW_TITLE"))
    }

    func test_map_createsViewModels() {
        let calendar = Calendar(identifier: .gregorian)
        let referenceDate = Date().adding(days: -10, calendar: calendar)
        let locale = Locale(identifier: "en_US_POSIX")
        
        let comments = [
            ImageComment(
                id: UUID(),
                message: "a message",
                createdAt: referenceDate.adding(minutes: -5, calendar: calendar),
                username: "a username"),
            ImageComment(
                id: UUID(),
                message: "another message",
                createdAt: referenceDate.adding(days: -1, calendar: calendar),
                username: "another username")
        ]
        
        let viewModel = ImageCommentsPresenter.map(
            comments,
            currentDate: referenceDate,
            calendar: calendar,
            locale: locale
        )
        
        XCTAssertEqual(viewModel.comments, [
            ImageCommentViewModel(
                message: "a message",
                date: "5 minutes ago",
                username: "a username"
            ),
            ImageCommentViewModel(
                message: "another message",
                date: "1 day ago",
                username: "another username"
            )
        ])
    }

    // MARK: - Helpers

    private func localized(_ key: String, file: StaticString = #filePath, line: UInt = #line) -> String {
        let table = "ImageComments"
        let bundle = Bundle(for: ImageCommentsPresenter.self)
        let value = bundle.localizedString(forKey: key, value: nil, table: table)
        if value == key {
            XCTFail("Missing localized string for key: \(key) in table: \(table)", file: file, line: line)
        }

        return value
    }
}
