//
//  CoreDataRecipeStore.swift
//  RecipeStore
//
//  Created by Christian Slanzi on 05.05.21.
//

import CoreData

public final class CoreDataRecipeStore: RecipeStore {

    private static let modelName = "RecipeStore"
    private static let model = NSManagedObjectModel(name: modelName, in: Bundle(for: CoreDataRecipeStore.self))
    
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    struct ModelNotFound: Error {
        let modelName: String
    }
    
    public init(storeURL: URL) throws {
        guard let model = CoreDataRecipeStore.model else {
            throw ModelNotFound(modelName: CoreDataRecipeStore.modelName)
        }
        
        container = try NSPersistentContainer.load(
            name: CoreDataRecipeStore.modelName,
            model: model,
            url: storeURL
        )
        context = container.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    public func insert(_ feed: [LocalRecipe], timestamp: Date, completion: @escaping InsertionCompletion) {
        let context = self.context
        context.perform {
            do {
                
                var items = [CoreDataRecipe]()
                
                for item in feed {
                    let cdRecipe = CoreDataRecipe(context: self.context)
                    
                    cdRecipe.id = Int16(item.id)
                    cdRecipe.calories = item.calories != nil ? (Int16(item.calories!)) : -1
                    cdRecipe.carbs = item.carbs
                    cdRecipe.fat = item.fat
                    cdRecipe.protein = item.protein
                    cdRecipe.image = item.image
                    cdRecipe.imageType = item.imageType
                    cdRecipe.title = item.title
                    
                    items.append(cdRecipe)
                }
                
                try self.context.save()
                completion(.none)
            } catch {
                self.context.reset()
                completion(.some(error))
            }
        }
    }
    
    public func retrieve(completion: @escaping RetrievalCompletion) {
        let context = self.context
        context.perform {
            let request: NSFetchRequest<CoreDataRecipe> = CoreDataRecipe.fetchRequest()
            do {
                let dataFeed = try self.context.fetch(request)
                if dataFeed.count > 0 {
                    let items = dataFeed.compactMap {
                        LocalRecipe(id: Int($0.id),
                                    calories: Int($0.calories),
                                    carbs: $0.carbs,
                                    fat: $0.fat,
                                    image: $0.image ?? "",
                                    imageType: $0.imageType ?? "",
                                    protein: $0.protein,
                                    title: $0.title ?? "")
                    }.sorted(by: { $0.id < $1.id })
                    completion(.found(feed: items))
                }
                else {
                   completion(.empty)
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        let context = self.context
        context.perform {
            let request: NSFetchRequest<CoreDataRecipe> = CoreDataRecipe.fetchRequest()
            do {
                /*
                if let dataFeed = try self.context.fetch(request).first {
                    self.context.delete(dataFeed)
                }*/
                let items = try self.context.fetch(request)
                for item in items {
                    self.context.delete(item)
                }
            
                try self.context.save()
                completion(.none)
            } catch {
                self.context.reset()
                completion(error)
            }
        }
    }
}
