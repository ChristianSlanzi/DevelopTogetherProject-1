//
//  MainRoute.swift
//  CookingApp
//
//  Created by Christian Slanzi on 01.05.21.
//

import UIKit

protocol MainRoute {
    func openMain()
}

extension MainRoute where Self: Router {
    
    func openMain(with transition: Transition) {

        //let router = DefaultRouter(rootTransition: transition)
        let viewController = CookingAppDependencies.shared.makeMainTabBarController()
        //router.root = viewController
        CookingAppDependencies.shared.setRootViewController(viewController)
        
        /*
        let navigationController = UINavigationController(rootViewController: viewController)
        router.root = viewController

        route(to: navigationController, as: transition)*/
    }

    func openMain() {
        openMain(with: EmptyTransition())
    }
}

extension DefaultRouter: MainRoute {}
