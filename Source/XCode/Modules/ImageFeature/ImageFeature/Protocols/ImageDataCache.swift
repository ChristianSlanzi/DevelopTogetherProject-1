//
//  ImageDataCache.swift
//  ImageFeature
//
//  Created by Christian Slanzi on 16.06.21.
//

import Foundation

public protocol ImageDataCache {
    typealias Result = Swift.Result<Void, Error>
    func save(_ data: Data, for url: URL, completion: @escaping (ImageDataCache.Result) -> Void)
}
