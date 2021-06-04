//
//  MainViewControllerFactory.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 04.06.21.
//

import NetworkingService
import CocktailsApiService

protocol MainViewControllerFactory {
    func makeMainViewController() -> ViewController
}

extension BartenderAppDependencies: MainViewControllerFactory {
    
    func makeMainViewController() -> ViewController {
        let httpClient = URLSessionHTTPClient(session: URLSession(configuration: .default))
        let service = CocktailsApiRemote(url: URL(string: "https://www.thecocktaildb.com/api/json/v1/1")!, client: httpClient)

        let viewModel = MainViewModel(service: service)
        let viewController = ViewController(viewModel: viewModel)
        return viewController
    }
}
