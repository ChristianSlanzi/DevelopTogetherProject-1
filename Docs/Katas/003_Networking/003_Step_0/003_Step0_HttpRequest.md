# Step 0: make the http request

Our client should be able to make a simple http request. This is a simple example of how we could do it.

```swift
let url = URL(string: "http://www.my-api.com/api-command?api-parameters")!
var request = URLRequest(url: url)
request.httpMethod = "get" 

let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
    guard let data = data else { return }
    print(String(data: data, encoding: .utf8)!)
}

task.resume()
```

There are several steps involved here: 

- Create a URL request.

- Set all the parameters.
- Create a URL Session and a task on it
- start the task
- On the completion closure, analyse the result of the request and perform different operations for different scenarios of failure and success. Returning the received data or an error to who started the request.

Furthermore, there are different types of api that requires different types of parameters, that uses different http methods, that return different errors or that need different operations to be performed on the data.

We should create a component that will be responsible to handle all the different requirements and cases. We should also model a public interface, so that the http client can also be easily replaced. For example with a mocked implementation. Or with a spy implementation, so we can spy the execution of the apis we'll later develop.

Let's call our interface HTTPClient.