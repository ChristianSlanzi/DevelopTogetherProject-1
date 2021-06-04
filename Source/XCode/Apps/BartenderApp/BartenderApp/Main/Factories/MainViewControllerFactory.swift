//
//  MainViewControllerFactory.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 04.06.21.
//

import Foundation

protocol MainViewControllerFactory {
    func makeMainViewController() -> ViewController

}

extension BartenderAppDependencies: MainViewControllerFactory {
    
    func makeMainViewController() -> ViewController {
        let viewController = ViewController()
        return viewController
    }
}
