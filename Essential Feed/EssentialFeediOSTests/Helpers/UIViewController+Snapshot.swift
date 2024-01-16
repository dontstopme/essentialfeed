//
//  UIViewController+Snapshot.swift
//  EssentialFeediOSTests
//
//  Created by Zoltan Damo on 07.01.2024.
//

import UIKit

extension UIViewController {
     func snapshot(for configuration: SnapshotConfiguration) -> UIImage {
         return SnapshotWindow(configuration: configuration, root: self).snapshot()
     }
 }

 struct SnapshotConfiguration {
     let size: CGSize
     let safeAreaInsets: UIEdgeInsets
     let layoutMargins: UIEdgeInsets
     let traitCollection: UITraitCollection

     static func iPhone15(style: UIUserInterfaceStyle, contentSize: UIContentSizeCategory = .large) -> SnapshotConfiguration {
         return SnapshotConfiguration(
            size: CGSize(width: 393.0, height: 852.0),
            safeAreaInsets: UIEdgeInsets(top: 59.0, left: 0.0, bottom: 34.0, right: 0.0),
            layoutMargins: UIEdgeInsets(top: 67.0, left: 8.0, bottom: 42.0, right: 8.0),
            traitCollection: UITraitCollection(mutations: { traits in
 				traits.forceTouchCapability = .unavailable
 				traits.layoutDirection = .leftToRight
 				traits.preferredContentSizeCategory = contentSize
 				traits.userInterfaceIdiom = .phone
 				traits.horizontalSizeClass = .compact
 				traits.verticalSizeClass = .regular
 				traits.displayScale = 3
 				traits.accessibilityContrast = .normal
 				traits.displayGamut = .P3
                traits.imageDynamicRange = .constrainedHigh
 				traits.userInterfaceStyle = style
 			}))
     }
 }

private final class SnapshotWindow: UIWindow {
    private var configuration: SnapshotConfiguration = .iPhone15(style: .light)

    convenience init(configuration: SnapshotConfiguration, root: UIViewController) {
        self.init(frame: CGRect(origin: .zero, size: configuration.size))
        self.configuration = configuration
        self.layoutMargins = configuration.layoutMargins
        self.rootViewController = root
        self.isHidden = false
        root.view.layoutMargins = configuration.layoutMargins
    }
    
    override var safeAreaInsets: UIEdgeInsets {
        return configuration.safeAreaInsets
    }
    
    override var traitCollection: UITraitCollection {
        configuration.traitCollection
    }
    
    func snapshot() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds, format: .init(for: traitCollection))
        return renderer.image { action in
            layer.render(in: action.cgContext)
        }
    }
}
