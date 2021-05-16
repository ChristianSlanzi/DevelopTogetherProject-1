//
//  RemoteLoader.swift
//  RecipeFeature
//
//  Created by Christian Slanzi on 12.05.21.
//

import Foundation
import CookingApiService //TODO: make indipendent


public enum CookingApiServiceError: Swift.Error {
    case connectivity
    case invalidData
    case notAuthorized
}


//TODO: try with the generic RemoteLoader

public class RemoteLoader: RecipeLoader {
    
    private let service: CookingApiService
    
    public init(service: CookingApiService) {
        self.service = service
    }
    public func load(completion: @escaping (RecipeLoader.Result) -> Void) {
        service.searchRecipes { (result) in
            switch result {
            case let .success(resultDTO):
                completion(.success(resultDTO.results.map({ (dto) -> Recipe in
                    Recipe(id: dto.id, calories: dto.calories, carbs: dto.carbs, fat: dto.fat, image: dto.image, imageType: dto.imageType, protein: dto.protein, title: dto.title)
                })))
                break
            case let .failure(error):
                completion(.failure(error))
                break
            }
        }
    }
}

