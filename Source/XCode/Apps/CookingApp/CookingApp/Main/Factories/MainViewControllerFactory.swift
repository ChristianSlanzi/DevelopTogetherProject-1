//
//  MainViewControllerFactory.swift
//  CookingApp
//
//  Created by Christian Slanzi on 05.06.21.
//

import UIKit
import NetworkingService
import CookingApiService

protocol MainViewControllerFactory {
    func makeMainViewController(router: RecipeRoute) -> UIViewController
}

extension CookingAppDependencies: MainViewControllerFactory {
    
    func makeMainViewController(router: RecipeRoute) -> UIViewController {
        
        let viewModel = MainViewModel(router: router)
        
        let networkingService = URLSessionHTTPClient(session: URLSession(configuration: .default))
        let serviceFactory = CookingApiServiceFactory(url: URL(string: "https://api.spoonacular.com")!,
                                                      client: networkingService,
                                                      apiKey: cookingApiKey)
        let service = serviceFactory.getCookingApiService()
        
        viewModel.cookingApiService = service
        viewModel.recipeInformationStore = recipeInformationStore
        
        let viewController = ViewController(viewModel: viewModel)
        
        return viewController
    }
}
