//
//  FeedViewControlle+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Zoltan Damo on 10/12/2023.
//

import UIKit
import EssentialFeediOS

extension FeedViewController {
    func simulateAppearance() {
        if !isViewLoaded {
            loadViewIfNeeded()
            prepareForFirstAppearance()
        }

        beginAppearanceTransition(true, animated: false)
        endAppearanceTransition()
    }
    
    func prepareForFirstAppearance() {
        setSmallFrameToPreventRenderingCells()
        replaceRefreshControlWithFakeRefreshControl()
    }

    private func setSmallFrameToPreventRenderingCells() {
        tableView.frame = CGRect(x: 0, y: 0, width: 390, height: 1)
    }

    func simulateUserInitiatedFeedReload() {
        refreshControl?.simulatePullToRefresh()
    }

    func simulateFeedImageViewNearVisible(at row: Int) {
         let ds = tableView.prefetchDataSource
         let index = IndexPath(row: row, section: feedImagesSection)
         ds?.tableView(tableView, prefetchRowsAt: [index])
     }

    func simulateFeedImageViewNotNearVisible(at row: Int) {
         simulateFeedImageViewNearVisible(at: row)

         let ds = tableView.prefetchDataSource
         let index = IndexPath(row: row, section: feedImagesSection)
         ds?.tableView?(tableView, cancelPrefetchingForRowsAt: [index])
     }

    func renderedFeedImageData(at index: Int) -> Data? {
        return simulateFeedImageViewVisible(at: index)?.renderedImage
    }

    var isShowingLoadingIndicator: Bool {
        return refreshControl?.isRefreshing == true
    }

    @discardableResult
     func simulateFeedImageViewVisible(at index: Int) -> FeedImageCell? {
         return feedImageView(at: index) as? FeedImageCell
     }

    @discardableResult
    func simulateFeedImageViewNotVisible(at row: Int) -> FeedImageCell? {
        let view = simulateFeedImageViewVisible(at: row)

        let delegate = tableView.delegate
        let index = IndexPath(row: row, section: feedImagesSection)
        delegate?.tableView?(tableView, didEndDisplaying: view!, forRowAt: index)

        return view
    }

    func numberOfRenderedFeedImageViews() -> Int {
         return tableView.numberOfRows(inSection: feedImagesSection)
     }

     func feedImageView(at row: Int) -> UITableViewCell? {
         guard numberOfRenderedFeedImageViews() > row else {
             return nil
         }

         let ds = tableView.dataSource
         let index = IndexPath(row: row, section: feedImagesSection)
         return ds?.tableView(tableView, cellForRowAt: index)
     }

     private var feedImagesSection: Int {
         return 0
     }
}

private extension FeedViewController {
    func replaceRefreshControlWithFakeRefreshControl() {
        let fakeRefreshControl = FakeRefreshControl()

        refreshControl?.allTargets.forEach { target in
            refreshControl?.actions(forTarget: target, forControlEvent: .valueChanged)?.forEach { action in
                fakeRefreshControl.addTarget(target, action: Selector(action), for: .valueChanged)
            }
        }

        refreshControl = fakeRefreshControl
    }
}
