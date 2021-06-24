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
    
    internal func getDrinkStore() -> DrinkStore {
        return drinkStore
    }
}
