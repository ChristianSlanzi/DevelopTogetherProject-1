//
//  CoreDataStore.swift
//  RecipeStore
//
//  Created by Christian Slanzi on 07.05.21.
//

import CoreData

extension NSManagedObjectContext: StorageContext {}

open class CoreDataStore<T: Storable & MappableProtocol>: DataStore {

    private let container: NSPersistentContainer
    fileprivate let context: NSManagedObjectContext
    private let model: NSManagedObjectModel
    
    public init(storeURL: URL, modelName: String, in bundle: Bundle) throws {
        
        guard let managedModel = NSManagedObjectModel(name: modelName, in: bundle) else {
            throw ModelNotFound(modelName: modelName)
        }
        
        model = managedModel
        
        container = try NSPersistentContainer.load(
            name: modelName,
            model: model,
            url: storeURL
        )
        context = container.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    struct ModelNotFound: Error {
        let modelName: String
    }
    
    public func create<T>(_ feed: [T], completion: @escaping CreationCompletion) where T : Storable & MappableProtocol {
        let context = self.context
        context.perform {
            do {
                
                _ = feed.map {
                    $0.mapToPersistenceObject(context: context)
                }
                
                try self.context.save()
                completion(.none)
            } catch {
                self.context.reset()
                completion(.some(error))
            }
        }
    }
    
    public func retrieve<T>(sortDescriptors: [NSSortDescriptor]?, completion: @escaping RetrievalCompletion<T>) where T : Storable & MappableProtocol {
        let context = self.context
        context.perform {
                        
            let request = T.PersistenceType.fetchRequest(sortDescriptors: sortDescriptors)
            do {
                let dataFeed = try self.context.fetch(request as! NSFetchRequest<NSFetchRequestResult>)
                if dataFeed.count > 0 {
                    let items = dataFeed.compactMap {
                        T.mapFromPersistenceObject($0 as! T.PersistenceType)
                    }
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
        
    public func deleteAll<T>(entity: T.Type, completion: @escaping DeletionCompletion<T>) where T : MappableProtocol, T : Storable {
        let context = self.context
        context.perform {
            
            let request = T.PersistenceType.fetchRequest(sortDescriptors: nil)
            do {
                /*
                if let dataFeed = try self.context.fetch(request).first {
                    self.context.delete(dataFeed)
                }*/
                let items = try self.context.fetch(request as! NSFetchRequest<NSFetchRequestResult>)
                for item in items {
                    self.context.delete(item as! NSManagedObject)
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
