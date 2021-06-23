//
//  ImageDataLoader.swift
//  ImageFeature
//
//  Created by Christian Slanzi on 16.06.21.
//

import Foundation
import CommonUtils

public protocol ImageDataLoaderTask {
    func cancel()
}

public protocol ImageDataLoader {
    typealias Result = Swift.Result<Data, Error>
    func loadImageData(from url: URL, completion: @escaping (ImageDataLoader.Result) -> Void) -> ImageDataLoaderTask
}

extension MainQueueDispatchDecorator: ImageDataLoader where T == ImageDataLoader {
    public func loadImageData(from url: URL, completion: @escaping (ImageDataLoader.Result) -> Void) -> ImageDataLoaderTask {
        decoratee.loadImageData(from: url) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}
