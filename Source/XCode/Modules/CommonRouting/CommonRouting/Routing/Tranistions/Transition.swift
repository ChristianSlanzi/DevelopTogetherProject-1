//
//  Transition.swift
//  CookingApp
//
//  Created by Christian Slanzi on 30.04.21.
//

import UIKit

public protocol Transition: AnyObject {
    var isAnimated: Bool { get set }

    func open(_ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?)
    func close(_ viewController: UIViewController, completion: (() -> Void)?)
}
