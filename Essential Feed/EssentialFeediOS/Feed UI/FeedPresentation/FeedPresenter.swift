//
//  FeedPresenter.swift
//  EssentialFeediOS
//
//  Created by Zoltan Damo on 14/12/2023.
//

import Essential_Feed

protocol FeedLoadingView {
    func display(_ viewModel: FeedLoadingViewModel)
}

protocol FeedView {
    func display(_ viewModel: FeedViewModel)
}

final class FeedPresenter {
    private let feedView: FeedView
    private let loadingView: FeedLoadingView

     init(feedView: FeedView, loadingView: FeedLoadingView) {
         self.feedView = feedView
         self.loadingView = loadingView
     }

 	func didStartLoadingFeed() {
 		loadingView.display(FeedLoadingViewModel(isLoading: true))
 	}

    func didFinishLoadingFeed(with feed: [FeedImage]) {
        feedView.display(FeedViewModel(feed: feed))
        loadingView.display(FeedLoadingViewModel(isLoading: false))
    }

    func didFinishLoadingFeed(with error: Error) {
        loadingView.display(FeedLoadingViewModel(isLoading: false))
    }
 }