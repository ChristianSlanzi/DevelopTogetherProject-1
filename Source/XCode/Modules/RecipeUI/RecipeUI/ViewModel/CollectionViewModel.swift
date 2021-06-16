//
//  CollectionViewModel.swift
//  RecipeBook
//
//  Created by Christian Slanzi on 09.05.21.
//

import Foundation
import RecipeFeature

public protocol RecipeRoute {
    func openRecipe(_ recipe: Recipe)
}

public protocol CollectionViewModelProtocol {
    func performInitialViewSetup()
    func loadData()
    func numberOfSections() -> Int
    func numberOfItemsInSection(_ section: Int) -> Int
    func cellViewModel(row: Int, section: Int) -> CollectionViewCellViewModel?
    func headerViewModel(section: Int) -> CollectionViewSectionHeaderViewModel?
    func didSelectItemAt(row: Int, section: Int)
}

public class CollectionViewModel: CollectionViewModelProtocol {
    
    weak var view: CollectionViewControllerProtocol?
    public var recipeLoader: RecipeLoader?
    public var recipeBook: RecipeBook?
    
    typealias Routes = RecipeRoute
    private let router: Routes
    private var title: String
    
    public init(title: String, view: CollectionViewControllerProtocol, router: RecipeRoute) {
        self.title = title
        self.view = view
        self.router = router
        
        if recipeBook == nil {
            recipeBook = RecipeBook()
        }
    }
    
    public func performInitialViewSetup() {
        
        view?.setNavigationTitle(title)
        view?.setSectionInset(top: 20, left: 0, bottom: 0, right: 0)
        view?.setupCollectionViewCellToUseMaxWidth()
        
        if let recipeBook = recipeBook, let categories = recipeBook.categories {
            if !categories.isEmpty {
                return
            }
        }
    }
    
    public func loadData() {
        recipeLoader?.loadRecipes(predicate: nil, completion: { (result) in
            switch result {
            case let .success(recipes):
                guard !recipes.isEmpty else {
                    let path = Bundle(for: CollectionViewModel.self).path(forResource: "RecipeBook", ofType: "plist")
                    self.recipeBook?.load(filePath: path)
                    self.view?.reload()
                    return
                }
                let category = RecipeCategory(id: 99, title: "", recipes: recipes.map({ (recipe) -> Recipe in
                    Recipe(id: recipe.id,
                           title: recipe.title,
                           image: recipe.image,
                           imageType: recipe.imageType,
                           calories: recipe.calories,
                           carbs: recipe.carbs,
                           fat: recipe.fat,
                           protein: recipe.protein)
                }))
                self.recipeBook?.categories?.append(category)
            case let .failure(error):
                print(error)
                let path = Bundle.main.path(forResource: "RecipeBook", ofType: "plist")
                self.recipeBook?.load(filePath: path)
            }
            self.view?.reload()
        })
    }
    
    public func numberOfSections() -> Int {
        return recipeBook?.categories?.count ?? 0
    }
    
    public func numberOfItemsInSection(_ section: Int) -> Int {
        guard let recipeBook = recipeBook,
            let categories = recipeBook.categories else {
                return 0
        }
        
        if ((section < 0) || (section >= categories.count)) {
            return 0
        }
        
        guard let recipes = categories[section].recipes else {
            return 0
        }
        
        return recipes.count
    }
    
    public func cellViewModel(row: Int, section: Int) -> CollectionViewCellViewModel? {
        
        guard let recipeBook = recipeBook,
              let categories = recipeBook.categories else {
                return nil
        }
        
        if ((section < 0) || (section >= categories.count)) {
            return nil
        }
        
        guard let recipes = categories[section].recipes else {
            return nil
        }
        
        if ((row < 0) || (row >= recipes.count)) {
            return nil
        }
        
        return CollectionViewCellViewModel(model: recipes[row])
    }
    
    public func headerViewModel(section: Int) -> CollectionViewSectionHeaderViewModel? {
        
        guard let recipeBook = recipeBook,
              let categories = recipeBook.categories else {
            return nil
            
        }
        
        if ((section < 0) || (section >= categories.count)) {
            return nil
        }
        
        return CollectionViewSectionHeaderViewModel(title: categories[section].title)
    }
    
    public func didSelectItemAt(row: Int, section: Int) {
        
        guard let recipeBook = recipeBook,
              let categories = recipeBook.categories else {
                return
        }
        
        if ((section < 0) || (section >= categories.count)) {
            return
        }
        
        guard let recipes = categories[section].recipes else {
            return
        }
        
        if ((row < 0) || (row >= recipes.count)) {
            return
        }
        
        router.openRecipe(recipes[row])
    }
}
