//
//  MainTabBarController.swift
//  CommonUI
//
//  Created by Christian Slanzi on 04.06.21.
//

import UIKit

open class MainTabBarController: UITabBarController {
    required public init(viewControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
