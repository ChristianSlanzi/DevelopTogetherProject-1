//
//  ModalTransition.swift
//  CookingApp
//
//  Created by Christian Slanzi on 01.05.21.
//

import UIKit

public final class ModalTransition: NSObject {
    public var isAnimated: Bool = true
    
    var modalTransitionStyle: UIModalTransitionStyle
    var modalPresentationStyle: UIModalPresentationStyle

    public init(isAnimated: Bool = true,
         modalTransitionStyle: UIModalTransitionStyle = .coverVertical,
         modalPresentationStyle: UIModalPresentationStyle = .automatic) {
        self.isAnimated = isAnimated
        self.modalTransitionStyle = modalTransitionStyle
        self.modalPresentationStyle = modalPresentationStyle
    }
}

extension ModalTransition: Transition {
    // MARK: - Transition

    public func open(_ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?) {
        viewController.modalPresentationStyle = modalPresentationStyle
        viewController.modalTransitionStyle = modalTransitionStyle
        from.present(viewController, animated: isAnimated, completion: completion)
    }

    public func close(_ viewController: UIViewController, completion: (() -> Void)?) {
        viewController.dismiss(animated: isAnimated, completion: completion)
    }
}
