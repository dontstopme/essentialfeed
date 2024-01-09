//
//  UIView+TestHelpers.swift
//  EssentialAppTests
//
//  Created by Zoltan Damo on 08.01.2024.
//

import UIKit

extension UIView {
    func enforceLayoutCycle() {
        layoutIfNeeded()
        RunLoop.current.run(until: Date())
    }
}
