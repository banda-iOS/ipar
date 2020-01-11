//
//  UIGestureRecognizerWithClosure.swift
//  ipar
//
//  Created by Vitaly on 07/01/2020.
//  Copyright © 2020 banda. All rights reserved.
//

import UIKit

final class BindableGestureRecognizer: UITapGestureRecognizer {
    private var action: () -> Void

    init(action: @escaping () -> Void) {
        self.action = action
        super.init(target: nil, action: nil)
        self.addTarget(self, action: #selector(execute))
    }

    @objc private func execute() {
        action()
    }
}
