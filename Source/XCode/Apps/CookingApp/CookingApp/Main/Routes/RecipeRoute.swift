//
//  RecipeRoute.swift
//  CookingApp
//
//  Created by Christian Slanzi on 30.04.21.
//

import Foundation
import RecipeFeature

protocol RecipeRoute {
    func openRecipe(_ recipe: Recipe)
}

extension RecipeRoute where Self: Router {

    func openRecipe(_ recipe: Recipe, with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewController = AppDependencies.shared.createRecipeDetailsViewController(recipe: recipe)
        router.root = viewController

        route(to: viewController, as: transition)
    }

    func openRecipe(_ recipe: Recipe) {
        openRecipe(recipe, with: PushTransition())
    }
}

extension DefaultRouter: RecipeRoute {}
