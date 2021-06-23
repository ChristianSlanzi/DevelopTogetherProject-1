//
//  LocalImageDataLoader.swift
//  ImageFeature
//
//  Created by Christian Slanzi on 16.06.21.
//

import Foundation

public final class LocalImageDataLoader {
    
}

extension LocalImageDataLoader: ImageDataLoader {
    
    public enum LoadError: Error {
        case failed
        case notFound
    }
    
    public func loadImageData(from url: URL, completion: @escaping (ImageDataLoader.Result) -> Void) -> ImageDataLoaderTask {
        
        let task =  LoadImageDataTask(completion)
        
        // TODO
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        
        if let data = cache.cachedResponse(for: request)?.data {
            completion(.success(data))
        } else {
            completion(.failure(LoadError.notFound))
        }
        
        return task
    }
}

extension LocalImageDataLoader: ImageDataCache {
    
    public typealias SaveResult = ImageDataCache.Result
    
    public enum SaveError: Error {
        case failed
    }
    
    public func save(_ data: Data, for url: URL, completion: @escaping (SaveResult) -> Void) {
        
        // TODO
        //let cache = URLCache.shared
        //cache.storeCachedResponse(CachedURLResponse(response: <#T##URLResponse#>, data: <#T##Data#>), for: <#T##URLRequest#>)
    }
}

private final class LoadImageDataTask: ImageDataLoaderTask {
    private var completion: ((ImageDataLoader.Result) -> Void)?
    
    init(_ completion: @escaping (ImageDataLoader.Result) -> Void) {
        self.completion = completion
    }
    
    func complete(with result: ImageDataLoader.Result) {
        completion?(result)
    }
    
    func cancel() {
        preventFurtherCompletions()
    }
    
    private func preventFurtherCompletions() {
        completion = nil
    }
}
