//
//  UserApiServiceTests.swift
//  UserApiServiceTests
//
//  Created by Christian Slanzi on 23.04.21.
//

import XCTest
@testable import UserApiService

class UserApiServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension UserApiServiceTests {
    
    // MARK: - Tests
    
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_getUsersListTwice_requestsDataFromURLTwice() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)

        sut.getUsersList { _ in }
        sut.getUsersList { _ in }

        XCTAssertEqual(client.requestedURLs, [url.appendingPathComponent("users"), url.appendingPathComponent("users")])
    }
    
    func test_getUsersList_deliversConnectivityErrorOnClientError() {
        let (sut, client) = makeSUT()

        expect(sut, toCompleteWith: .failure(.connectivity), when: {
            let clientError = NSError(domain: "Test", code: 0)
            client.complete(with: clientError)
        })
    }
    
    func test_getUsersList_deliversInvalidDataErrorOnNon200HTTPResponse() {
        let (sut, client) = makeSUT()

        let samples = [199, 201, 300, 400, 500]

        samples.enumerated().forEach { index, code in
            expect(sut, toCompleteWith: .failure(.invalidData), when: {
                let json = makeItemsJSON([])
                client.complete(withStatusCode: code, data: json, at: index)
            })
        }
    }
    
    func test_getUsersList_deliversInvalidDataErrorOn200HTTPResponseWithInvalidJSON() {
        let (sut, client) = makeSUT()

        expect(sut, toCompleteWith: .failure(.invalidData), when: {
            let invalidJSON = Data("invalid json".utf8)
            client.complete(withStatusCode: 200, data: invalidJSON)
        })
    }
    
    func test_getUsersList_deliversSuccessWithNoItemsOn200HTTPResponseWithEmptyJSONList() {
        let (sut, client) = makeSUT()

        expect(sut, toCompleteWith: .success(UserData()), when: {
            let emptyListJSON = makeItemsJSON([])
            client.complete(withStatusCode: 200, data: emptyListJSON)
        })
    }
    
    func test_getUsersList_deliversSuccessWithItemsOn200HTTPResponseWithJSONItems() {
        let (sut, client) = makeSUT()

        let user1 = makeItem(id: 0, firstName: "John", lastName: "Doe", avatar: "")

        let user2 = makeItem(id: 1, firstName: "Donald", lastName: "Duck", avatar: "")

        let users = [user1.model, user2.model]
        
        let userData = UserData(page: 0,
                                perPage: 2,
                                total: 2,
                                totalPages: 1,
                                data: users)

        expect(sut, toCompleteWith: .success(userData), when: {
            let json = makeUserDataJSON(page: 0, perPage: 2, total: 2, totalPages: 1, users: [user1.json, user2.json])
            client.complete(withStatusCode: 200, data: json)
        })
    }
    
    func test_getUsersList_doesNotDeliverResultAfterSUTInstanceHasBeenDeallocated() {
        let url = URL(string: "http://any-url.com")!
        let client = HTTPClientSpy()
        var sut: UserApiRemote? = UserApiRemote(url: url, client: client)

        var capturedResults = [UserApiService.UserDataResult]()
        sut?.getUsersList { capturedResults.append($0) }

        sut = nil
        client.complete(withStatusCode: 200, data: makeItemsJSON([]))

        XCTAssertTrue(capturedResults.isEmpty)
    }
    
    // -----------------------------------------
    
    func test_getSingleUserTwice_requestsDataFromURLTwice() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)

        sut.getSingleUser(id: 1) { _ in }
        sut.getSingleUser(id: 1) { _ in }

        XCTAssertEqual(client.requestedURLs, [url.appendingPathComponent("users/1"), url.appendingPathComponent("users/1")])
    }
    
    func test_getSingleUser_deliversConnectivityErrorOnClientError() {
        let (sut, client) = makeSUT()

        expect(sut, toCompleteGetSingleUserWith: .failure(.connectivity), when: {
            let clientError = NSError(domain: "Test", code: 0)
            client.complete(with: clientError)
        })
    }
    
    func test_getSingleUser_deliversInvalidDataErrorOnNon200HTTPResponse() {
        let (sut, client) = makeSUT()

        let samples = [199, 201, 300, 400, 500]

        samples.enumerated().forEach { index, code in
            expect(sut, toCompleteGetSingleUserWith: .failure(.invalidData), when: {
                let json = makeItemsJSON([])
                client.complete(withStatusCode: code, data: json, at: index)
            })
        }
    }
    
    func test_getSingleUser_deliversInvalidDataErrorOn200HTTPResponseWithInvalidJSON() {
        let (sut, client) = makeSUT()

        expect(sut, toCompleteGetSingleUserWith: .failure(.invalidData), when: {
            let invalidJSON = Data("invalid json".utf8)
            client.complete(withStatusCode: 200, data: invalidJSON)
        })
    }
    
    func test_getSingleUser_deliversSuccessWithNoItemsOn200HTTPResponseWithEmptyJSONList() {
        let (sut, client) = makeSUT()

        expect(sut, toCompleteGetSingleUserWith: .success(SingleUserData()), when: {
            let emptyListJSON = makeItemsJSON([])
            client.complete(withStatusCode: 200, data: emptyListJSON)
        })
    }
    
    func test_getSingleUser_deliversSuccessWithItemsOn200HTTPResponseWithJSONItems() {
        let (sut, client) = makeSUT()

        let user1 = makeItem(id: 0, firstName: "John", lastName: "Doe", avatar: "")

        let userData = SingleUserData(data: user1.model)

        expect(sut, toCompleteGetSingleUserWith: .success(userData), when: {
            let json = makeSingleUserDataJSON(user: user1.json)
            client.complete(withStatusCode: 200, data: json)
        })
    }
    
    func test_getSingleUser_doesNotDeliverResultAfterSUTInstanceHasBeenDeallocated() {
        let url = URL(string: "http://any-url.com")!
        let client = HTTPClientSpy()
        var sut: UserApiRemote? = UserApiRemote(url: url, client: client)

        var capturedResults = [UserApiService.SingleUserDataResult]()
        sut?.getSingleUser(id: 1) { capturedResults.append($0) }

        sut = nil
        client.complete(withStatusCode: 200, data: makeItemsJSON([]))

        XCTAssertTrue(capturedResults.isEmpty)
    }
    
    // ----------------------------------------
    
    func test_createUser_deliversInvalidDataErrorOn201HTTPResponseWithInvalidJSON() {
        let (sut, client) = makeSUT()

        expect(sut, toCompleteCreateUserWith: .failure(.invalidData), when: {
            let invalidJSON = Data("invalid json".utf8)
            client.complete(withStatusCode: 201, data: invalidJSON)
        })
    }
    
    func test_createUserTwice_requestsDataFromURLTwice() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)

        sut.createUser { _ in }
        sut.createUser { _ in }

        XCTAssertEqual(client.requestedURLs, [url.appendingPathComponent("users"), url.appendingPathComponent("users")])
    }
    
    func test_createUser_deliversConnectivityErrorOnClientError() {
        let (sut, client) = makeSUT()

        expect(sut, toCompleteCreateUserWith: .failure(.connectivity), when: {
            let clientError = NSError(domain: "Test", code: 0)
            client.complete(with: clientError)
        })
    }
    
    func test_createUser_deliversInvalidDataErrorOnNon201HTTPResponse() {
        let (sut, client) = makeSUT()

        let samples = [199, 200, 300, 400, 500]

        samples.enumerated().forEach { index, code in
            expect(sut, toCompleteCreateUserWith: .failure(.invalidData), when: {
                let json = makeItemsJSON([])
                client.complete(withStatusCode: code, data: json, at: index)
            })
        }
    }

    func test_createUser_deliversSuccessWithNoItemsOn201HTTPResponseWithEmptyJSONList() {
        let (sut, client) = makeSUT()

        expect(sut, toCompleteCreateUserWith: .failure(.invalidData), when: {
            let emptyListJSON = makeItemsJSON([])
            client.complete(withStatusCode: 201, data: emptyListJSON)
        })
    }

    func test_createUser_deliversSuccessWithItemsOn201HTTPResponseWithJSONItems() {
        let (sut, client) = makeSUT()

        let user1 = makeJobUser(id: "0", name: "John", job: "Developer", createdAt: "11-10-2020")

        expect(sut, toCompleteCreateUserWith: .success(user1.model), when: {
            client.complete(withStatusCode: 201, data: makeJobUserData(user: user1.json))
        })
    }

    func test_createUser_doesNotDeliverResultAfterSUTInstanceHasBeenDeallocated() {
        let url = URL(string: "http://any-url.com")!
        let client = HTTPClientSpy()
        var sut: UserApiRemote? = UserApiRemote(url: url, client: client)

        var capturedResults = [UserApiService.JobUserResult]()
        sut?.createUser { capturedResults.append($0) }

        sut = nil
        client.complete(withStatusCode: 201, data: makeItemsJSON([]))

        XCTAssertTrue(capturedResults.isEmpty)
    }
}

extension UserApiServiceTests {
    
    // MARK: - Helpers
    
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!, file: StaticString = #file, line: UInt = #line) -> (sut: UserApiRemote, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = UserApiRemote(url: url, client: client)
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(client, file: file, line: line)
        return (sut, client)
    }
    
    private func makeItem(id: Int, firstName: String? = nil, lastName: String? = nil, avatar: String? = nil) -> (model: User, json: [String: Any]) {
        let item = User(id: id, firstName: firstName, lastName: lastName, avatar: avatar)
        
        let json = [
            "id": id,
            "first_name": firstName as Any,
            "last_name": lastName as Any,
            "avatar": avatar as Any
        ].compactMapValues { $0 }
        
        return (item, json)
    }
    
    private func makeItemsJSON(_ items: [[String: Any]]) -> Data {
        let json = ["items": items]
        return try! JSONSerialization.data(withJSONObject: json)
    }
    
    private func makeUserDataJSON(page: Int?, perPage: Int?, total: Int?, totalPages: Int?, users: [[String: Any]]) -> Data {
        let json: [String: Any] = ["page": page as Any,
                                   "per_page": perPage as Any,
                                   "total": total as Any,
                                   "total_pages": totalPages as Any,
                                   "data": users]
        return try! JSONSerialization.data(withJSONObject: json)
    }
    
    private func makeSingleUserDataJSON(user: [String: Any]) -> Data {
        let json: [String: Any] = ["data": user]
        return try! JSONSerialization.data(withJSONObject: json)
    }
    
    private func makeJobUser(id: String, name: String? = nil, job: String? = nil, createdAt: String? = nil) -> (model: JobUser, json: [String: Any]) {
        let item = JobUser(id: id, name: name, job: job, createdAt: createdAt!)
        
        let json = [
            "id": id,
            "name": name as Any,
            "job": job as Any,
            "created_at": createdAt as Any
        ].compactMapValues { $0 }
        
        return (item, json)
    }
    
    private func makeJobUserData(user: [String: Any]) -> Data {
        return try! JSONSerialization.data(withJSONObject: user)
    }
}
