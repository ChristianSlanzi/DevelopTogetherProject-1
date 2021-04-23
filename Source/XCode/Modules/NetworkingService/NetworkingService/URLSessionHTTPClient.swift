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
    
    var httpBody: Data?
    
    private func getHttpBody() -> Data? {
        
        guard let contentType = requestHttpHeaders.value(forKey: "Content-Type") else { return nil }
        
        if contentType.contains("application/json") {
            
            return try? JSONSerialization.data(withJSONObject: httpBodyParameters.allValues(), options: [.prettyPrinted, .sortedKeys])
            
        } else if contentType.contains("application/x-www-form-urlencoded") {
            
            let bodyString = httpBodyParameters
                .allValues()
                .map { "\($0)=\(String(describing: $1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)))" }
                .joined(separator: "&")
            return bodyString.data(using: .utf8)
            
        } else {
     
            return httpBody
            
        }
    }
    
    private func addURLQueryParameters(toURL url: URL) -> URL {
        
        if urlQueryParameters.totalItems() > 0 {
            guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return url }

            var queryItems = [URLQueryItem]()
            for (key, value) in urlQueryParameters.allValues() {
                let item = URLQueryItem(name: key, value: value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
             
                queryItems.append(item)
            }
            
            urlComponents.queryItems = queryItems
             
            guard let updatedURL = urlComponents.url else { return url }
            return updatedURL
        }
        
        return url
    }
    
    private func prepareRequest(withURL url: URL?, httpBody: Data?, httpMethod: HTTPMethod) -> URLRequest? {
        
        guard let url = url else { return nil }
            
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        for (header, value) in requestHttpHeaders.allValues() {
            request.setValue(value, forHTTPHeaderField: header)
        }
        
        request.httpBody = httpBody
        return request
    }
    
    public func makeRequest(toURL url: URL, withHttpMethod httpMethod: HTTPMethod, completion: @escaping (HTTPClientResult) -> Void) {
        
        let targetURL = addURLQueryParameters(toURL: url)
        let httpBody = getHttpBody()
        
        guard let request = prepareRequest(withURL: targetURL, httpBody: httpBody, httpMethod: httpMethod) else {
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

enum HTTPClientCustomError: Error {
    case failedToCreateRequest
}

extension HTTPClientCustomError: LocalizedError {
    
    public var localizedDescription: String {
        switch self {
            case .failedToCreateRequest: return NSLocalizedString("Unable to create the URLRequest", comment: "")
        }
    }
}
