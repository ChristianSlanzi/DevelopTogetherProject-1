//
//  MainTabBarController.swift
//  CookingApp
//
//  Created by Christian Slanzi on 30.04.21.
//

import UIKit

final class MainTabBarController: UITabBarController {
    required init(viewControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
