//
//  URLSessionHTTPClient.swift
//  NetworkingService
//
//  Created by Christian Slanzi on 23.04.21.
//

public class URLSessionHTTPClient: HTTPClient {
    
    private let session: URLSession
    
    public init(session: URLSession) {
        self.requestHttpHeaders = HTTPClientEntity()
        self.urlQueryParameters = HTTPClientEntity()
        self.httpBodyParameters = HTTPClientEntity()
        self.session = session
    }
    
    public var requestHttpHeaders: HTTPClientEntity
    public var urlQueryParameters: HTTPClientEntity
    public var httpBodyParameters: HTTPClientEntity
    
    private func prepareRequest(withURL url: URL?, httpMethod: HTTPMethod) -> URLRequest? {
        
        guard let url = url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        return request
    }
    
    public func makeRequest(toURL url: URL, withHttpMethod httpMethod: HTTPMethod, completion: @escaping (HTTPClientResult) -> Void) {
        
        guard let request = prepareRequest(withURL: url, httpMethod: httpMethod) else {
            //TODO: we should completed with an error, before we return
            return
        }
        
        let task = self.session.dataTask(with: request) { (data, response, error) in
            
            completion(HTTPClientResult(withData: data,
                                        response: HTTPClientResponse(fromURLResponse: response),
                                        error: error))
        }
        
        task.resume()
    }
    
    public func getData(fromURL url: URL, completion: @escaping (Data?) -> Void) {
        
    }
    
}
