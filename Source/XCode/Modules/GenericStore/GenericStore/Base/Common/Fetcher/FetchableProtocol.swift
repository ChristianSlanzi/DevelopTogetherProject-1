//
//  FetchableProtocol.swift
//  RecipeStore
//
//  Created by Christian Slanzi on 07.05.21.
//

public protocol FetchableProtocol {
    associatedtype PersistenceType
    associatedtype FetchRequest
    static func fetchRequest(sortDescriptors: [NSSortDescriptor]?) -> FetchRequest
}
