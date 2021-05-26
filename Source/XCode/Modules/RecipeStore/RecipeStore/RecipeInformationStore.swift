//
//  RecipeInformationStore.swift
//  RecipeStore
//
//  Created by Christian Slanzi on 26.05.21.
//

import GenericStore

public enum RetrieveCachedRecipeInformationResult {
    case empty
    case found(feed: LocalRecipeInformation)
    case failure(Error)
}

public typealias InfoRetrievalCompletion = (RetrieveDataResult<LocalRecipeInformation>) -> Void
public typealias InfoDeletionCompletion = (Error?) -> Void

public protocol RecipeInformationStore {
    func create(_ feed: [LocalRecipeInformation], completion: @escaping DataStore.CreationCompletion)
    func retrieve(sortDescriptors: [NSSortDescriptor]?, completion: @escaping InfoRetrievalCompletion)
    func deleteAll(entity: LocalRecipeInformation.Type, completion: @escaping InfoDeletionCompletion)
}
extension CoreDataRecipeInformationStore : RecipeInformationStore {

}
