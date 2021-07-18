//
//  MappableProtocol.swift
//  RecipeStore
//
//  Created by Christian Slanzi on 04.05.21.
//

// MARK: - MappableProtocol
public protocol MappableProtocol {
    
    associatedtype PersistenceType: Storable & FetchableProtocol
    
    // MARK: - Method
    func mapToPersistenceObject(_ object: PersistenceType?, context: StorageContext) -> PersistenceType
    static func mapFromPersistenceObject(_ object: PersistenceType) -> Self
    
}
