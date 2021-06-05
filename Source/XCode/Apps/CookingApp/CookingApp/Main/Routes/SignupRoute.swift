//
//  SignupRoute.swift
//  CookingApp
//
//  Created by Christian Slanzi on 01.05.21.
//

import Foundation

protocol SignupRoute {
    func openSignup()
}

extension SignupRoute where Self: Router {

    func openSignup(with transition: Transition) {

        let router = DefaultRouter(rootTransition: transition)
        let viewController = CookingAppDependencies.shared.createSignupViewController()
        router.root = viewController

        route(to: viewController, as: transition)
    }

    func openSignup() {
        openSignup(with: ModalTransition())
    }
}

extension DefaultRouter: SignupRoute {}
