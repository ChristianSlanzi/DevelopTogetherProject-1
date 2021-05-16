//
//  RecipeLoader.swift
//  RecipeFeature
//
//  Created by Christian Slanzi on 11.05.21.
//

import Foundation

public protocol RecipeLoader {
    typealias Result = Swift.Result<[Recipe], Error>
    
    func load(completion: @escaping (Self.Result) -> Void)
}
