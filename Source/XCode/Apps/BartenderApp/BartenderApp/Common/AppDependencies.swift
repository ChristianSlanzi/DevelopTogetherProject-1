//
//  AppDependencies.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 04.06.21.
//

import UIKit

public class AppDependencies {
    
    private var window: UIWindow?
    
    public init() {
        configureDependencies()
    }
    
    private func configureDependencies() {
        
    }
    
    internal func setRootViewController(_ viewController: UIViewController) {
        setRootViewController(viewController, window: getWindow())
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

    public func start() {
        
    }
}
