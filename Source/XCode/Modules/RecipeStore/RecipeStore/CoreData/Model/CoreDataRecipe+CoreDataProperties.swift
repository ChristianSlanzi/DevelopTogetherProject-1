//
//  CoreDataRecipe+CoreDataProperties.swift
//  RecipeStore
//
//  Created by Christian Slanzi on 21.04.21.
//
//

import Foundation
import CoreData


extension CoreDataRecipe {

    @NSManaged public var idCode: Int16
    @NSManaged public var calories: Int16
    @NSManaged public var carbs: String?
    @NSManaged public var fat: String?
    @NSManaged public var protein: String?
    @NSManaged public var image: String?
    @NSManaged public var imageType: String?
    @NSManaged public var title: String?

}

extension CoreDataRecipe : Identifiable {

}
