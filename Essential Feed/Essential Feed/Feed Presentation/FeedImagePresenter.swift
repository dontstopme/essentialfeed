//
//  FeedImagePresenter.swift
//  Essential Feed
//
//  Created by Zoltan Damo on 17/12/2023.
//

import Foundation

public final class FeedImagePresenter {
    
    public static func map(_ image: FeedImage) -> FeedImageViewModel {
        FeedImageViewModel(
            description: image.description,
            location: image.location
         )
    }
}
