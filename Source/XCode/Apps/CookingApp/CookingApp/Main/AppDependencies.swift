//
//  AppDependencies.swift
//  CookingApp
//
//  Created by Christian Slanzi on 27.04.21.
//

import UIKit

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

    public func setScene(_ scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        window?.makeKeyAndVisible()
    }

}

extension AppDependencies {
    
    private func createMainViewController() -> UIViewController {
        let viewController = ViewController()
        return viewController
    }
}

extension AppDependencies {
    
    public func start() {
        setRootViewController(createMainViewController(), window: window)
    }
}
