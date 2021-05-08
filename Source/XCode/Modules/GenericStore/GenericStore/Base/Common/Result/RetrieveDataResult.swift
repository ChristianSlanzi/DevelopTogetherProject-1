//
//  RetrieveDataResult.swift
//  RecipeStore
//
//  Created by Christian Slanzi on 07.05.21.
//

public enum RetrieveDataResult<T> {
    case empty
    case found(feed: [T])
    case failure(Error)
}
