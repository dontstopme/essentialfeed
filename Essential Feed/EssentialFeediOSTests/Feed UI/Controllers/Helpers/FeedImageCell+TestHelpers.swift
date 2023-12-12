//
//  FeedImageCell+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Zoltan Damo on 10/12/2023.
//

import UIKit
import EssentialFeediOS

extension FeedImageCell {
    func simulateRetryAction() {
         feedImageRetryButton.simulateTap()
     }

    var isShowingLocation: Bool {
         return !locationContainer.isHidden
     }

    var isShowingImageLoadingIndicator: Bool {
         return feedImageContainer.isShimmering
     }

    var locationText: String? {
        return locationLabel.text
    }

    var isShowingRetryAction: Bool {
         return !feedImageRetryButton.isHidden
     }

    var descriptionText: String? {
        return descriptionLabel.text
    }

    var renderedImage: Data? {
         return feedImageView.image?.pngData()
     }
}
