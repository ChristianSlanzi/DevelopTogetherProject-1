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

enum Tabs {
    case main
    case search
    case favorites
    case profile

    var index: Int {
        switch self {
        case .main:
            return 0
        case .search:
            return 1
        case .favorites:
            return 1
        case .profile:
            return 1
        }
    }

    var item: UITabBarItem {
        switch self {
        case .main:
            return UITabBarItem(title: "Home", image: nil, tag: index)
        case .search:
            return UITabBarItem(title: "Search", image: nil, tag: index)
        case .favorites:
            return UITabBarItem(title: "Favorites", image: nil, tag: index)
        case .profile:
            return UITabBarItem(title: "Profile", image: nil, tag: index)
        }
    }
}

class AppDependencies {
    
    static let shared = AppDependencies()
    
    private var window: UIWindow?
    
    private lazy var recipeStore: RecipeStore /*& RecipeDataStore*/ = {
        do {
            return try CoreDataRecipeStore(
                storeURL: NSPersistentContainer
                    .defaultDirectoryURL()
                    .appendingPathComponent("feed-store.sqlite"))
        } catch {
            assertionFailure("Failed to instantiate CoreData store with error: \(error.localizedDescription)")
            
            //TODO
            /*
            logger.fault("Failed to instantiate CoreData store with error: \(error.localizedDescription)")
            
            */
            return NullStore()
        }
    }()
    
    private lazy var recipeInformationStore: RecipeInformationStore /*& RecipeDataStore*/ = {
        do {
            return try CoreDataRecipeInformationStore(
                storeURL: NSPersistentContainer
                    .defaultDirectoryURL()
                    .appendingPathComponent("recipe-info-store.sqlite"))
        } catch {
            assertionFailure("Failed to instantiate CoreData store with error: \(error.localizedDescription)")
            
            //TODO
            /*
            logger.fault("Failed to instantiate CoreData store with error: \(error.localizedDescription)")
            
            */
            return NullStore()
        }
    }()

    private init() {
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

extension AppDependencies {
    
    func makeMainTab() -> UIViewController {
        
        var FLAG = true
        
        if FLAG {
            let router = DefaultRouter(rootTransition: EmptyTransition())
            let recipeListVC = RecipeUI_SDK.createRecipelistVC(router: router)
            router.root = recipeListVC
            recipeListVC.viewModel?.recipeLoader = makeCompositeRecipeLoader()
            
            return UINavigationController(rootViewController: recipeListVC)
        }
        
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewController = createMainViewController(router: router)
        router.root = viewController
        
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.tabBarItem = Tabs.main.item
        return navigation
    }
    
    func makeSearchTab() -> UIViewController {
        let navigation = UINavigationController(rootViewController: createSearchViewController())
        navigation.tabBarItem = Tabs.search.item
        return navigation
    }
    
    func makeFavoritesTab() -> UIViewController {
        let navigation = UINavigationController(rootViewController: createFavoritesViewController())
        navigation.tabBarItem = Tabs.favorites.item
        return navigation
    }
    
    func makeProfileTab() -> UIViewController {
        let navigation = UINavigationController(rootViewController: createProfileViewController())
        navigation.tabBarItem = Tabs.profile.item
        return navigation
    }
    
    internal func createMainTabBarController() -> UIViewController {
        let tabs = [makeMainTab(), makeSearchTab(), makeFavoritesTab(), makeProfileTab()]
        let tabController = MainTabBarController(viewControllers: tabs)
        return tabController
    }
    
    internal func createMainViewController(router: RecipeRoute) -> UIViewController {
        
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
    
    internal func createSearchViewController() -> UIViewController {
        let viewModel = SearchViewModel()
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
    
    internal func createRecipeDetailsViewController(recipe: RecipeFeature.Recipe) -> UIViewController {
        let viewModel = RecipeDetailsViewModel(recipe: recipe)
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

extension AppDependencies {
    
    public func start() {
        login()
        return;
        
        let mainRouter = DefaultRouter(rootTransition: EmptyTransition())
        setRootViewController(createMainViewController(router: mainRouter))
    }
    
    public func login() {
        var isUserLoggedIn = true
        
        //if we have credentials
        if isUserLoggedIn {
            //routeToMainViewController()
            setRootViewController(createMainTabBarController())
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

extension AppDependencies {
    
    private var cookingApiKey: String {
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
