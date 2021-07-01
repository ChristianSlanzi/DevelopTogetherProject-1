//
//  EmptyTransition.swift
//  CookingApp
//
//  Created by Christian Slanzi on 30.04.21.
//

import UIKit

public final class EmptyTransition {
    public var isAnimated: Bool = true
    
    public init() {}
}

extension EmptyTransition: Transition {
    // MARK: - Transition

    public func open(_ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?) {}
    public func close(_ viewController: UIViewController, completion: (() -> Void)?) {}
}
