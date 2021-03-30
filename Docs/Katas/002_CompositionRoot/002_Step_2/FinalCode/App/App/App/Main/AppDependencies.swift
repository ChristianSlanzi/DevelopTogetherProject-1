//
//  AppDependencies.swift
//  App
//

import UIKit

protocol LoginRouting: class {
    func routeToSignupViewController()
    func routeToMainViewController()
}

class AppDependencies {
    
    static let shared = AppDependencies()
    
    private var window: UIWindow?

    private init() {
        configureDependencies()
    }
    
    private func configureDependencies() {
        
    }
    
    private func setRootViewController(_ viewController: UIViewController, window: UIWindow?) {
        window?.rootViewController = viewController
    }
    
    private func createLoginViewController() -> LoginViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        let viewModel = LoginViewModel(view: controller)
        controller.viewModel = viewModel
        controller.routing = self
        
        return controller
    }
    
    private func createSignupViewController() -> SignupViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        
        let viewModel = SignupViewModel(view: controller)
        controller.viewModel = viewModel
        
        return controller
    }
    
    private func createMainViewController() -> UIViewController {
        return ViewController()
    }
    
    public func setScene(_ scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        window?.makeKeyAndVisible()
    }

    public func login() {
        var isUserLoggedIn = false
        
        //if we have credentials
        if isUserLoggedIn {
            routeToMainViewController()
        } else {
            setRootViewController(createLoginViewController(), window: window)
        }
    }
    
    public func logout() {
        //remove credentials
    
        //call login
        setRootViewController(createLoginViewController(), window: window)
    }
}

extension AppDependencies: LoginRouting {
    func routeToSignupViewController() {
        window?.rootViewController?.present(createSignupViewController(), animated: true)
    }
    func routeToMainViewController() {
        setRootViewController(createMainViewController(), window: window)
    }
}
