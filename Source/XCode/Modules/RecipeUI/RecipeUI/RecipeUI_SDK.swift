//
//  RecipeUI.swift
//  RecipeUI
//
//  Created by Christian Slanzi on 13.05.21.
//

import UIKit
import ImageFeature

public class RecipeUI_SDK {
    
    public static func createRecipelistVC(title: String, router: RecipeRoute, imageLoader: ImageDataLoader) -> CollectionViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: RecipeUI_SDK.self))
        let recipeListVC = storyboard.instantiateViewController(identifier: "CollectionViewController") as! CollectionViewController
        let viewModel = CollectionViewModel(title: title, view: recipeListVC, router: router, imageLoader: imageLoader)
        recipeListVC.viewModel = viewModel
        return recipeListVC
    }
}
