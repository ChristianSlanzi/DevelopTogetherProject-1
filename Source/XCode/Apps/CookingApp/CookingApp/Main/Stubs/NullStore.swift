//
//  NullStore.swift
//  CookingApp
//
//  Created by Christian Slanzi on 13.05.21.
//

import Foundation
import RecipeStore

class NullStore: RecipeStore {
    
    init() {
        try! super.init(storeURL: URL(fileURLWithPath: ""), modelName: "", in: Bundle(for: NullStore.self))
    }
}

//Try to make the RecipeStore just to be a protocol
//and then make the CoreDataStore<LocalRecipe> conform to the RecipeStore protocol
//the client should be fine now as it is no more depending from a generic.

//extension NullStore: RecipeStore {
//
//}
