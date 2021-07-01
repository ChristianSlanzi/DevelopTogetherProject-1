//
//  LoginRoute.swift
//  CookingApp
//
//  Created by Christian Slanzi on 01.05.21.
//

import UIKit
import CommonRouting

protocol LoginRoute {
    func openLogin()
}

extension LoginRoute where Self: Router {
    
    func openLogin(with transition: Transition) {

        let router = DefaultRouter(rootTransition: transition)
        let viewController = CookingAppDependencies.shared.createLoginViewController()
        router.root = viewController
        
        let navigationController = UINavigationController(rootViewController: viewController)
        router.root = viewController

        route(to: navigationController, as: transition)
    }

    func openLogin() {
        openLogin(with: ModalTransition())
    }
}

extension DefaultRouter: LoginRoute {}
