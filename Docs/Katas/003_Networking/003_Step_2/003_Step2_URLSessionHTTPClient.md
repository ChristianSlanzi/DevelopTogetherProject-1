# Step 2: the URLSessionHTTPClient concrete implementation

We want to create a new class that conforms to our protocol:

```swift
public class URLSessionHTTPClient: HTTPClient {
  public var requestHttpHeaders = HTTPClientEntity()
  public var urlQueryParameters = HTTPClientEntity()
  public var httpBodyParameters = HTTPClientEntity()

	public func makeRequest(toURL url: URL,
                     withHttpMethod httpMethod: HTTPMethod,
                     completion: @escaping (_ result: HTTPClientResult) -> Void) {
		// TODO: make a request on a url session
  }
}
```

So let's implement the makeRequest method:

```swift
public func makeRequest(toURL url: URL,
                        withHttpMethod httpMethod: HTTPMethod,
                        completion: @escaping (_ result: HTTPClientResult) -> Void) {
  
  guard let url = url else { return nil }
  
	var request = URLRequest(url: url)
	request.httpMethod = httpMethod.rawValue

  let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
     completion(HTTPClientResult(withData: data,
                                 response: HTTPClientResponse(fromURLResponse: response),
                                 error: error))
  }

  task.resume()
}
```

Before we continue with the implementation (we still miss to set the headers, add query parameters, set the httpbody...  ), we should remove that fix dependency on the shared instance of URLSession to allow instead the client's user to inject it's own session instance. 

```swift
public class URLSessionHTTPClient: HTTPClient {
  private let session: URLSession

  public init(session: URLSession) {
    self.session = session
  }
  
  public func makeRequest(...) {
    ...
    let task = self.session.dataTask(with: request) { ...
			...
    }
		...
  }
}
```

There are two steps here already. The first one prepares the request and the second part actually makes the request on the session. So let's extrapolate the preparation in it's own method.

```swift
private func prepareRequest(withURL url: URL?, httpMethod: HTTPMethod) -> URLRequest? {
     
  guard let url = url else { return nil }

  var request = URLRequest(url: url)
  request.httpMethod = httpMethod.rawValue

  return request
}

public func makeRequest(toURL url: URL,
                        withHttpMethod httpMethod: HTTPMethod,
                        completion: @escaping (_ result: HTTPClientResult) -> Void) {
    
	guard let request = prepareRequest(withURL: url, httpMethod: httpMethod) else {
		//TODO: we should completed with an error, before we return
    return
  }

  let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
     completion(HTTPClientResult(withData: data,
                                 response: HTTPClientResponse(fromURLResponse: response),
                                 error: error))
  }

  task.resume()
}
```

We can now add the query parameters. Query parameters can be added to a URL as queryItems parameter. We create a private helper method for that:

```swift
private func addURLQueryParameters(toURL url: URL) -> URL {
        
  if urlQueryParameters.totalItems() > 0 {
    guard var urlComponents = URLComponents(url: url, 
                                            resolvingAgainstBaseURL: false) else { 
      return url 
    }

    var queryItems = [URLQueryItem]()
    for (key, value) in urlQueryParameters.allValues() {
			let encodedValue = value.addingPercentEncoding(
        																				withAllowedCharacters: .urlQueryAllowed)
      let item = URLQueryItem(name: key, 
                              value: encodedValue)

      queryItems.append(item)
    }

    urlComponents.queryItems = queryItems

    guard let updatedURL = urlComponents.url else { return url }
    return updatedURL
  }

  return url
}
```

But for post request we have to set the parameters as http body on the request. So we need another helper method:

```swift
var httpBody: Data?

private func getHttpBody() -> Data? {
        
  guard let contentType = requestHttpHeaders.value(forKey: "Content-Type") else { 
    return nil 
  }

  if contentType.contains("application/json") {

    return try? JSONSerialization.data(withJSONObject: httpBodyParameters.allValues(), 
                                       options: [.prettyPrinted, .sortedKeys])

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
```

We also added an optional var httpBody: Data? to our client that we can use as last option of the getHttpBody method. We do this because we might want to inject a generated httpBody to our request, we'll see that in the future. 
We can modify our prepareRequest method.

```swift
private func prepareRequest(withURL url: URL?, 
                            httpBody: Data?, 
                            httpMethod: HTTPMethod) -> URLRequest? {
        
  guard let url = url else { return nil }

  var request = URLRequest(url: url)
  request.httpMethod = httpMethod.rawValue

  for (header, value) in requestHttpHeaders.allValues() {
    request.setValue(value, forHTTPHeaderField: header)
  }

  request.httpBody = httpBody
  return request
}
```

We are now ready to get back on the makeRequest method:

```swift
public func makeRequest(toURL url: URL,
                        withHttpMethod httpMethod: HTTPMethod,
                        completion: @escaping (_ result: HTTPClientResult) -> Void) {
  
	let targetURL = addURLQueryParameters(toURL: url)
  let httpBody = getHttpBody()  
	
	guard let request = prepareRequest(withURL: targetURL, 
                                     httpBody: httpBody, 
                                     httpMethod: httpMethod) else {
		//TODO: we should completed with an error, before we return
    return
  }

  let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
     completion(HTTPClientResult(withData: data,
                                 response: HTTPClientResponse(fromURLResponse: response),
                                 error: error))
  }

  task.resume()
}
```

Let's create a custom error for the case where we fail to create the request.

```swift
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
```

and finally we can complete the implementation of makeRequest method by replacing the TODO with the following:

```swift
guard let request = ... else
{
  completion(HTTPClientResult(withError: HTTPClientCustomError.failedToCreateRequest))
  return
}
```

Our URLSessionHTTPClient is ready!

