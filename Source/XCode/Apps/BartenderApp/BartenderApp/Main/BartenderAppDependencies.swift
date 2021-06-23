//
//  BartenderAppDependencies.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 04.06.21.
//
import CommonUtils
import ImageFeature
import NetworkingService
import CocktailsApiService

class BartenderAppDependencies: AppDependencies {
    
    static let shared = BartenderAppDependencies()
    
    var imageDataLoader: ImageDataLoader!
    
    override func start() {
        super.start()
        
        imageDataLoader = makeImageDataLoader()
        setRootViewController(makeMainTabBarController())
    }
    
    internal func makeImageDataLoader() -> ImageDataLoader {
        let loader = RemoteImageDataLoader(client: URLSessionHTTPClient(session: URLSession(configuration: .default)))
        return  MainQueueDispatchDecorator(decoratee: loader)
    }
    
    internal func makeCocktailsApiService() -> CocktailsApiService {
        let httpClient = URLSessionHTTPClient(session: URLSession(configuration: .default))
        let service = CocktailsApiRemote(url: URL(string: "https://www.thecocktaildb.com/api/json/v1/1")!, client: httpClient)
        return service
    }
}
