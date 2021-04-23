# Networking

The login signup module misses all the networking stuff for being able to work with a real system. 

App mobile client server communications are mostly all based on Rest API and Https Networking. We'll first develop a common Http Client that we'll later inject in our login api system. In this way we are able to test the http client and later to test the api client in isolation by spying the http client. The http client will be reused for every api client we need to develop.

### List of Steps

| #    | Title                                                        | Description                                 | Started    |
| ---- | ------------------------------------------------------------ | ------------------------------------------- | ---------- |
| 000  | [make the http request](003_Step_0/003_Step0_HttpRequest.md) | Let's analyse the anatomy of a http request | 2021-03-29 |
| 001  | [the HTTPClient protocol](003_Step_1/003_Step1_HTTPClient.md) | Define the HTTPClient protocol              | 2021-03-29 |
| 002  | [URLSessionHTTPClient](003_Step_2/003_Step2_URLSessionHTTPClient.md) | URLSessionHTTPClient, the concrete client   | 2021-03-29 |

