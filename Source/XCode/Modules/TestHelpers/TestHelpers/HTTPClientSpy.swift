//
//  HTTPClientSpy.swift
//  UserApiServiceTests
//
//  Created by Christian Slanzi on 23.04.21.
//

import XCTest
import NetworkingService

public class HTTPClientSpy: HTTPClient {
    
    public init() {}
    
    private var messages = [(url: URL, completion: (HTTPClientResult) -> Void)]()
    
    public var requestedURLs: [URL] {
        return messages.map { $0.url }
    }
    
    public var requestHttpHeaders: HTTPClientEntity = HTTPClientEntity()
    public var urlQueryParameters: HTTPClientEntity = HTTPClientEntity()
    public var httpBodyParameters: HTTPClientEntity = HTTPClientEntity()
    
    public func makeRequest(toURL url: URL, withHttpMethod httpMethod: HTTPMethod, completion: @escaping (HTTPClientResult) -> Void) {
        messages.append((url, completion))
    }
    
    public func getData(fromURL url: URL, completion: @escaping (Data?) -> Void) {
        
    }
    
    public func complete(with error: Error, at index: Int = 0, file: StaticString = #file, line: UInt = #line) {
        guard messages.count > index else {
            return XCTFail("Can't complete request never made", file: file, line: line)
        }

        messages[index].completion(HTTPClientResult(withError: error))
    }
    
    public func complete(withStatusCode code: Int, data: Data, at index: Int = 0, file: StaticString = #file, line: UInt = #line) {
        guard requestedURLs.count > index else {
            return XCTFail("Can't complete request never made", file: file, line: line)
        }
        
        let response = HTTPURLResponse(
            url: requestedURLs[index],
            statusCode: code,
            httpVersion: nil,
            headerFields: nil
        )!
        
        messages[index].completion(HTTPClientResult(withData: data, response: HTTPClientResponse(fromURLResponse: response), error: nil))
    }
    
}
