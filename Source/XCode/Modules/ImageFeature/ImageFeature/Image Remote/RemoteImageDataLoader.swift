//
//  RemoteImageDataLoader.swift
//  ImageFeature
//
//  Created by Christian Slanzi on 16.06.21.
//

import Foundation
import NetworkingService

public class RemoteImageDataLoader: ImageDataLoader {
    
    public typealias Result = (ImageDataLoader.Result) -> Void
    
    private let client: HTTPClient
    
    public init(client: HTTPClient) {
        self.client = client
    }
    
    public enum Error: Swift.Error {
        case invalidData
        case connectivity
    }
    
    private final class HTTPClientTaskWrapper: ImageDataLoaderTask {
        private var completion: ((ImageDataLoader.Result) -> Void)?
        var wrapped: HTTPClientTask?
        
        init(_ completion: @escaping (ImageDataLoader.Result) -> Void) {
            self.completion = completion
        }
        
        func complete(with result: ImageDataLoader.Result) {
            completion?(result)
        }
        
        func cancel() {
            preventFurtherComlpetions()
            wrapped?.cancel()
        }
        
        private func preventFurtherComlpetions() {
            completion = nil
        }
    }
    
    public func loadImageData(from url: URL, completion: @escaping Result) -> ImageDataLoaderTask {
        
        let task = HTTPClientTaskWrapper(completion)
        
        task.wrapped = client.makeRequest(toURL: url,
                                          withHttpMethod: .get,
                                          cachePolicy: .returnCacheDataElseLoad,
                                          timeoutInterval: 30) { [weak self] result in
            
            guard self != nil else { return }
            task.complete(with: self!.decodeResult(result: result))
        }
       
        return task
    }
    
    private func decodeResult(result: HTTPClientResult) -> Swift.Result<Data, Swift.Error> {
        
        if let response = result.response {
            if response.statusCode != 200 {
                return .failure(Error.invalidData)
            }
        }  else {
            return .failure(Error.connectivity)
        }
        
        if let data = result.data {
            return .success(data)
            /*
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let jsonStr = String(decoding: data, as: UTF8.self)
                print(jsonStr)
                let userData = try decoder.decode(Data.self, from: data)
                print(userData.description)
                return .success(userData)
            } catch {
                print(error)
                return .failure(Error.invalidData)
            }
            */
        } else {
            return .failure(Error.invalidData)
        }
    }
}
