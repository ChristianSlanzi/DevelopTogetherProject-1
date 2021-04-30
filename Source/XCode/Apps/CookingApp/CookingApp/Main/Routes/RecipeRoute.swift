//
//  RecipeRoute.swift
//  CookingApp
//
//  Created by Christian Slanzi on 30.04.21.
//

import Foundation

protocol RecipeRoute {
    func openRecipe()
}

extension RecipeRoute where Self: Router {

    func openRecipe(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewController = AppDependencies.shared.createRecipeDetailsViewController()
        router.root = viewController

        route(to: viewController, as: transition)
    }

    func openRecipe() {
        openRecipe(with: PushTransition())
    }
}

extension DefaultRouter: RecipeRoute {}
