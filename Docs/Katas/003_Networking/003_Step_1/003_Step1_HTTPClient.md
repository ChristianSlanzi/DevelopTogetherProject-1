# Step 1: Model the HTTPClient protocol

Let's start with the simple definition of a protocol.

```swift
public protocol HTTPClient {}
```

Then we said our client should be able to make an http request. 

```swift
public protocol HTTPClient {
  func makeRequest(toURL url: URL)
}
```

And we want to get a result back. And because the operation is asynchronous, we need to call an injected completion closure. The be able to do that, the closure has to marked as escaping.

```swift
public protocol HTTPClient {
  func makeRequest(toURL url: URL,
                     completion: @escaping (_ result: HTTPClientResult) -> Void))
}
```

But what is the result? It is the result of an http request, a combination of data, response and error. We'll create a new custom type called HTTPClientResult.

```swift
public struct HTTPClientResult {
  public var data: Data?
  public var response: HTTPClientResponse?
  public var error: Error?

  public init(withData data: Data?, response: HTTPClientResponse?, error: Error?) {
    self.data = data
    self.response = response
    self.error = error
  }

  public init(withError error: Error) {
    self.error = error
  }
}
```

We want also to be able to inspect the url response, sometime just to know its status code, sometime we want also to look more inside the response headers. For this reason, we also create a custom object HTTPClientResponse where we could add some inspection logic.

```swift
public struct HTTPClientResponse {
    
  var response: URLResponse?
  public var statusCode: Int = 0
  public var headers = HTTPClientEntity()

  public init(fromURLResponse response: URLResponse?) {
    guard let response = response else { return }
    self.response = response
    statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0

    if let headerFields = (response as? HTTPURLResponse)?.allHeaderFields { 
      for (key, value) in headerFields {
      	headers.add(value: "\(value)", forKey: "\(key)")
    	}
    }
  }
}
```

The headers are a map of key, values. Requests can also have headers. Let's define our custom class for this puspose.

```swift
public struct HTTPClientEntity {
    
  private var values: [String: String] = [:]

  public init() {}

  public mutating func add(value: String, forKey key: String) {
    values[key] = value
  }

  public func value(forKey key: String) -> String? {
    return values[key]
  }

  public func allValues() -> [String: String] {
    return values
  }

  public func totalItems() -> Int {
    return values.count
  }
}
```

For requests, query parameters and body parameters are also maps of key, values. Let's add all these features back to our HTPPClient.

```swift
public protocol HTTPClient {
  
  var requestHttpHeaders: HTTPClientEntity { get set }
  var urlQueryParameters: HTTPClientEntity { get set }
  var httpBodyParameters: HTTPClientEntity { get set }
  
  func makeRequest(toURL url: URL,
                     completion: @escaping (_ result: HTTPClientResult) -> Void))
}
```

We still miss the possibility to specify the type of request. The most common is the get request, but a post request is also common for Rest Api System and in some cases you could also need a put, a patch or a delete. Let's model the http method and let's change our protocol.

```swift
public protocol HTTPClient {
  
  var requestHttpHeaders: HTTPClientEntity { get set }
  var urlQueryParameters: HTTPClientEntity { get set }
  var httpBodyParameters: HTTPClientEntity { get set }
  
  func makeRequest(toURL url: URL,
									 withHttpMethod httpMethod: HTTPMethod,
                   completion: @escaping (_ result: HTTPClientResult) -> Void))
}

public enum HTTPMethod: String {
  case get
  case post
  case put
  case patch
  case delete
}
```

Our protocol is ready!

Now we can create a concrete implementation on this protocol where to implement the makeRequest method.

One way to create a url request on ios is through the URLSession. So let's call our concrete implementation URLSessionHTTPClient.

