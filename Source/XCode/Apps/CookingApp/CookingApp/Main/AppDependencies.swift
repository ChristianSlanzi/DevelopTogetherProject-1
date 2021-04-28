//
//  AppDependencies.swift
//  CookingApp
//
//  Created by Christian Slanzi on 27.04.21.
//

import UIKit
import LoginSignupModule

class AppDependencies {
    
    static let shared = AppDependencies()
    

    private var window: UIWindow?

    private init() {
        configureDependencies()
    }
    
    private func configureDependencies() {
        
    }
    
    internal func setRootViewController(_ viewController: UIViewController, window: UIWindow?) {
        window?.rootViewController = viewController
    }

    public func setScene(_ scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        window?.makeKeyAndVisible()
    }
    
    public func getWindow() -> UIWindow? {
        return window
    }

}

extension AppDependencies {
    
    internal func createMainViewController() -> UIViewController {
        let viewController = ViewController()
        return viewController
    }
    
    private func createLoginViewController() -> LoginViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        let viewModel = LoginViewModel(view: controller)
        
        let loginController = LoginController(delegate: viewModel)
        let userApiService = LoginSignupWrapper()
        loginController.userApiService = userApiService
        viewModel.loginController = loginController
        
        controller.viewModel = viewModel
        controller.routing = self
        
        return controller
    }
    
    internal func createSignupViewController() -> SignupViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController

        let viewModel = SignupViewModel(view: controller)
        
        let signupController = SignupController(delegate: viewModel)
        let userApiService = LoginSignupWrapper()
        signupController.userApiService = userApiService
        viewModel.signupController = signupController
        
        controller.viewModel = viewModel
        controller.routing = self
        
        return controller
    }
}

extension AppDependencies {
    
    public func start() {
        login()
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
