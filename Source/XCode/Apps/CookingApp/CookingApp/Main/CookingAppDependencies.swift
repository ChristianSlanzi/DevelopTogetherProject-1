//
//  AppDependencies.swift
//  CookingApp
//
//  Created by Christian Slanzi on 27.04.21.
//

import UIKit
import LoginSignupModule
import NetworkingService
import CookingApiService
import RecipeStore
import RecipeUI
import RecipeFeature
import CoreData
import GenericStore

class CookingAppDependencies: AppDependencies {
    
    static let shared = CookingAppDependencies()
    
    private lazy var modelName: String = {
        return "RecipeStore"
    }()
    private lazy var managedModel: NSManagedObjectModel = {
    
        do {
            guard let managedModel = NSManagedObjectModel(name: modelName, in: Bundle(for: CoreDataRecipeStore.self)) else {
                throw ModelNotFound(modelName: modelName)
            }
            return managedModel
        } catch {
            assertionFailure("Failed to instantiate CoreData store with error: \(error.localizedDescription)")
        }
        return NSManagedObjectModel()
    }()
        
    private lazy var recipeStore: RecipeStore /*& RecipeDataStore*/ = {
        do {
            return try CoreDataRecipeStore(
                storeURL: NSPersistentContainer
                    .defaultDirectoryURL()
                    .appendingPathComponent("feed-store.sqlite"), managedModel: managedModel)
        } catch {
            assertionFailure("Failed to instantiate CoreData store with error: \(error.localizedDescription)")
            
            //TODO
            /*
            logger.fault("Failed to instantiate CoreData store with error: \(error.localizedDescription)")
            
            */
            return NullStore()
        }
    }()
    
    internal lazy var recipeInformationStore: RecipeInformationStore /*& RecipeDataStore*/ = {
        do {
            return try CoreDataRecipeInformationStore(
                storeURL: NSPersistentContainer
                    .defaultDirectoryURL()
                    .appendingPathComponent("recipe-info-store.sqlite"), managedModel: managedModel)
        } catch {
            assertionFailure("Failed to instantiate CoreData store with error: \(error.localizedDescription)")
            
            //TODO
            /*
            logger.fault("Failed to instantiate CoreData store with error: \(error.localizedDescription)")
            
            */
            return NullStore()
        }
    }()
    
    internal lazy var favoriteRecipeStore: FavoriteRecipeStore /*& RecipeDataStore*/ = {
        do {
            return try CoreDataFavoriteRecipeStore(
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
    
    public override func start() {
        super.start()
        login()
        return;
        
        let mainRouter = DefaultRouter(rootTransition: EmptyTransition())
        setRootViewController(makeMainViewController(router: mainRouter))
    }
}

extension DefaultRouter: RecipeUI.RecipeRoute {
    func openRecipe(_ recipe: RecipeUI.Recipe) {
        let recipeFeat = RecipeFeature.Recipe(id: recipe.id,
                                              calories: recipe.calories,
                                              carbs: recipe.carbs,
                                              fat: recipe.fat,
                                              image: recipe.image,
                                              imageType: recipe.imageType,
                                              protein: recipe.protein,
                                              title: recipe.title)
        openRecipe(recipeFeat)
    }
}

extension CookingAppDependencies {
    
    internal func createSearchViewController(router: SearchRoute) -> UIViewController {
        let viewModel = SearchViewModel(router: router)
        viewModel.recipeLoader = makeCompositeRecipeLoader()
        let viewController = SearchViewController(viewModel: viewModel)
        return viewController
    }
    
    internal func createFavoritesViewController() -> UIViewController {
        let viewController = FavoritesViewController()
        return viewController
    }
    
    internal func createProfileViewController() -> UIViewController {
        let viewController = ProfileViewController()
        return viewController
    }
    
    internal func createRecipeListViewController(recipes: [RecipeFeature.Recipe]) -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let recipeListVC = RecipeUI_SDK.createRecipelistVC(router: router)
        router.root = recipeListVC
        recipeListVC.viewModel?.recipeBook = RecipeBook()
        let category = RecipeCategory(id: 99, title: "", recipes: recipes.map({ (recipe) -> RecipeUI.Recipe in
            Recipe(id: recipe.id, title: recipe.title, image: recipe.image, imageType: recipe.imageType)
        }))
        recipeListVC.viewModel?.recipeBook?.categories?.append(category)
        //.recipeLoader = makeCompositeRecipeLoader()
        
        return recipeListVC
    }
    
    internal func createRecipeDetailsViewController(recipe: RecipeFeature.Recipe) -> UIViewController {
        let recipeManager = RecipeManager(store: favoriteRecipeStore, currentDate: { Date() })
        let viewModel = RecipeDetailsViewModel(recipe: recipe, recipeManager: recipeManager)
        let viewController = RecipeDetailsViewController(viewModel: viewModel)
        viewModel.view = viewController
        
        let networkingService = URLSessionHTTPClient(session: URLSession(configuration: .default))
        let serviceFactory = CookingApiServiceFactory(url: URL(string: "https://api.spoonacular.com")!,
                                                      client: networkingService,
                                                      apiKey: cookingApiKey)
        let service = serviceFactory.getCookingApiService()
        let remoteLoader = RemoteInformationLoader(service: service)
        let localLoader = LocalRecipeInformationLoader(store: recipeInformationStore, currentDate: { Date() })
        let recipeLoader = RecipeInformationCompositeFallbackLoader(remote: remoteLoader, local: localLoader)
        viewModel.recipeLoader = recipeLoader

        return viewController
    }
    
    internal func createLoginViewController() -> LoginViewController {
        let mainRouter = DefaultRouter(rootTransition: EmptyTransition())
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        let viewModel = LoginViewModel(view: controller, router: mainRouter)
        
        let loginController = LoginController(delegate: viewModel)
        let userApiService = LoginSignupWrapper()
        loginController.userApiService = userApiService
        viewModel.loginController = loginController
        
        controller.viewModel = viewModel
        mainRouter.root = controller
        
        return controller
    }
    
    internal func createSignupViewController() -> SignupViewController {
        
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController

        let viewModel = SignupViewModel(view: controller, router: router)
        
        let signupController = SignupController(delegate: viewModel)
        let userApiService = LoginSignupWrapper()
        signupController.userApiService = userApiService
        viewModel.signupController = signupController
        
        controller.viewModel = viewModel
        router.root = controller
        
        return controller
    }
    
    internal func makeCompositeRecipeLoader() -> RecipeLoader {
        let networkingService = URLSessionHTTPClient(session: URLSession(configuration: .default))
        let serviceFactory = CookingApiServiceFactory(url: URL(string: "https://api.spoonacular.com")!,
                                                      client: networkingService,
                                                      apiKey: cookingApiKey)
        let service = serviceFactory.getCookingApiService()
        let remoteLoader = RemoteLoader(service: service)
        let localLoader = LocalRecipesLoader(store: recipeStore, currentDate: { Date() })
        let recipeLoader = CompositeFallbackLoader(remote: remoteLoader, local: localLoader)
        return recipeLoader
    }
}

extension CookingAppDependencies {
    
    public func login() {
        var isUserLoggedIn = true
        
        //if we have credentials
        if isUserLoggedIn {
            //routeToMainViewController()
            setRootViewController(makeMainTabBarController())
        } else {
            setRootViewController(createLoginViewController())
        }
    }
    
    public func logout() {
        //remove credentials
    
        //call login
        setRootViewController(createLoginViewController())
    }
}

// MARK: - Secrets

extension CookingAppDependencies {
    
    internal var cookingApiKey: String {
      get {
        // 1 - search for the secrets plist file
        guard let filePath = Bundle.main.path(forResource: "Secrets-Info", ofType: "plist") else {
          //fatalError("Couldn't find file 'Secrets.plist'.")
            print("Couldn't find file 'Secrets.plist'.")
            return "COOKING_API_KEY-NOT-FOUND"
        }
        // 2
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "COOKING_API_KEY") as? String else {
          //fatalError("Couldn't find key 'COOKING_API_KEY' in 'Secrets-Info.plist'.")
            print("Couldn't find key 'COOKING_API_KEY' in 'Secrets-Info.plist'.")
            return "COOKING_API_KEY-NOT-FOUND"
        }
        // 3
        if (value.starts(with: "_")) {
          //fatalError("Register for a Spoonacular developer account and get an API key at https://spoonacular.com/food-api")
            print("Couldn't find key 'COOKING_API_KEY' in 'Secrets-Info.plist'.")
            return "COOKING_API_KEY-NOT-FOUND"
        }
        return value
      }
    }
}
