//
//  HTTPClient.swift
//  NetworkingService
//
//  Created by Christian Slanzi on 23.04.21.
//

import Foundation

public protocol HTTPClient {
    
    var requestHttpHeaders: HTTPClientEntity { get set }
    var urlQueryParameters: HTTPClientEntity { get set }
    var httpBodyParameters: HTTPClientEntity { get set }
    
    func makeRequest(toURL url: URL,
                     withHttpMethod httpMethod: HTTPMethod,
                     completion: @escaping (_ result: HTTPClientResult) -> Void)
    
    func getData(fromURL url: URL, completion: @escaping (_ data: Data?) -> Void)
}

public enum HTTPMethod: String {
    case get
    case post
    case put
    case patch
    case delete
}

public struct HTTPClientResult {
    
}

public struct HTTPClientEntity {
    
}
