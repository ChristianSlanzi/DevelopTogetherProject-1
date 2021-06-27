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
import CoreData
import GenericStore
import DrinkStore
import CommonUI

class BartenderAppDependencies: AppDependencies {
    
    static let shared = BartenderAppDependencies()
    
    var imageDataLoader: ImageDataLoader!
    
    private lazy var modelName: String = {
        return "DrinkStore"
    }()
    private lazy var managedModel: NSManagedObjectModel = {
    
        do {
            guard let managedModel = NSManagedObjectModel(name: modelName, in: Bundle(for: CoreDataDrinkStore.self)) else {
                throw ModelNotFound(modelName: modelName)
            }
            return managedModel
        } catch {
            assertionFailure("Failed to instantiate CoreData store with error: \(error.localizedDescription)")
        }
        return NSManagedObjectModel()
    }()
        
    private lazy var drinkStore: DrinkStore = {
        do {
            return try CoreDataDrinkStore(
                storeURL: NSPersistentContainer
                    .defaultDirectoryURL()
                    .appendingPathComponent("drink-store.sqlite"), managedModel: managedModel)
        } catch {
            assertionFailure("Failed to instantiate CoreData store with error: \(error.localizedDescription)")
            
            //TODO
            /*
            logger.fault("Failed to instantiate CoreData store with error: \(error.localizedDescription)")
            
            */
            return NullStore()
        }
    }()
    
    private lazy var favoriteDrinkStore: FavoriteDrinkStore /*& RecipeDataStore*/ = {
        do {
            return try CoreDataFavoriteDrinkStore(
                storeURL: NSPersistentContainer
                    .defaultDirectoryURL()
                    .appendingPathComponent("favorite-store.sqlite"), managedModel: managedModel)
        } catch {
            assertionFailure("Failed to instantiate CoreData store with error: \(error.localizedDescription)")
            
            //TODO
            /*
            logger.fault("Failed to instantiate CoreData store with error: \(error.localizedDescription)")
            
            */
            return NullStore()
        }
    }()
    
    private lazy var cocktailsManager: CocktailsManaging = {
        getDrinkManager()
    }()
    
    override func start() {
        super.start()
        
        //getDrinkManager().load(query: " ") { _ in }
        for char in "abcdefghijklmnopqrstuvwxyz" {
            cocktailsManager.loadDrinksByFirstLetter(char) { _ in }
        }
        
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
    
    internal func getDrinkStore() -> DrinkStore {
        return drinkStore
    }
    internal func getFavoriteDrinkStore() -> FavoriteDrinkStore {
        return favoriteDrinkStore
    }
    internal func makeFavoriteDataSource() -> CustomDataSource<Drink> {
        return FavoriteDataSource(loader: cocktailsManager)
    }
    internal func getDrinkManager() -> CocktailsManaging {
        let compositeFallbackLoader = makeCompositeDrinkLoader()
        let drinkManager = CocktailsManager(store: getFavoriteDrinkStore(), cocktailsLoader: compositeFallbackLoader) {
            Date()
        }
        return drinkManager
        
    }
}
