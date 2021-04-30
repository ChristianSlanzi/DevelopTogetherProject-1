//
//  EmptyTransition.swift
//  CookingApp
//
//  Created by Christian Slanzi on 30.04.21.
//

import UIKit

final class EmptyTransition {
    var isAnimated: Bool = true
}

extension EmptyTransition: Transition {
    // MARK: - Transition

    func open(_ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?) {}
    func close(_ viewController: UIViewController, completion: (() -> Void)?) {}
}
