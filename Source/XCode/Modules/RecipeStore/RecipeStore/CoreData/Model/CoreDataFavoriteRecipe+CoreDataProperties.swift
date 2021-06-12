//
//  CoreDataFavoriteRecipe+CoreDataProperties.swift
//  
//
//  Created by Christian Slanzi on 09.06.21.
//
//

import Foundation
import CoreData


extension CoreDataFavoriteRecipe {

//    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataFavoriteRecipe> {
//        return NSFetchRequest<CoreDataFavoriteRecipe>(entityName: "CoreDataFavoriteRecipe")
//    }

    @NSManaged public var idCode: Int32

}

extension CoreDataFavoriteRecipe : Identifiable {

}
