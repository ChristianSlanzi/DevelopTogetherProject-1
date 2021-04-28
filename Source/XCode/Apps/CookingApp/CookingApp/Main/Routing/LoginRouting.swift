//
//  LoginRouting.swift
//  CookingApp
//
//  Created by Christian Slanzi on 28.04.21.
//

protocol LoginRouting: class {
    func routeToSignupViewController()
    func routeToMainViewController()
}

extension AppDependencies: LoginRouting {
    func routeToSignupViewController() {
        getWindow()?.rootViewController?.present(createSignupViewController(), animated: true)
    }
    func routeToMainViewController() {
        setRootViewController(createMainViewController(), window: getWindow())
    }
}
