//
//  HTTPClientSpy.swift
//  UserApiServiceTests
//
//  Created by Christian Slanzi on 23.04.21.
//

import XCTest
import NetworkingService

class HTTPClientSpy: HTTPClient {
    
    private var messages = [(url: URL, completion: (HTTPClientResult) -> Void)]()
    
    var requestedURLs: [URL] {
        return messages.map { $0.url }
    }
    
    var requestHttpHeaders: HTTPClientEntity = HTTPClientEntity()
    var urlQueryParameters: HTTPClientEntity = HTTPClientEntity()
    var httpBodyParameters: HTTPClientEntity = HTTPClientEntity()
    
    func makeRequest(toURL url: URL, withHttpMethod httpMethod: HTTPMethod, completion: @escaping (HTTPClientResult) -> Void) {
        messages.append((url, completion))
    }
    
    func getData(fromURL url: URL, completion: @escaping (Data?) -> Void) {
        
    }
    
}
