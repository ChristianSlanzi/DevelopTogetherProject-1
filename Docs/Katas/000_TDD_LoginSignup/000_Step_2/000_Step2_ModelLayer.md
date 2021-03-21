# Step 2: Building the Model Layer

- Let's TDD the LoginModel class!

- create a XCTestCase class named LoginModelTests under LoginSignupModuleTests/Model group

- remember to import the Production module

  ```swift
  @testable import LoginSignupModule
  ```

- add following properties to the Test class

  ```swift
  private let validDummyUserName: String = "username"
  private let validDummyPassword: String = "Aryb4N79"
  private let invalidDummyUserName: String = "u%"
  private let invalidDummyPassword: String = "abc"
  private let emptyDummyUserName: String = ""
  private let emptyDummyPassword: String = ""
  ```

- add first test function

  ```swift
  func testLoginModel_ValidUserName_ValidPassword_CanBeInstantiated() {
     let loginModel = LoginModel(userName: validDummyUserName, 
                                 password: validDummyPassword)
     XCTAssertNotNil(loginModel)
  }
  ```

- The test is broken! (Red Flag). To fix it, we need to create a LoginModel class in production code:

  ```swift
  class LoginModel: NSObject {
    
    var userName: String
    var password: String
  
    init?(userName: String, password: String) {
    	self.userName = userName
      self.password = password
    }
  }
  ```

- The test is fixed! (Green Flag). If we run the test, the assertion is satisfied.

- Refactor. Well, there's nothing to refactor at the moment.

- add second test function

  ```swift
  func testLoginModel_InvalidUserName_ValidPassword_CanNotBeInstantiated() {
    let loginModel = LoginModel(userName: invalidDummyUserName,
                                password: validDummyPassword)
    XCTAssertNil(loginModel)
  }
  ```

- The test is broken! (Red Flag). To fix it, we need to .... validate the username

- ```swift
  class LoginModel: NSObject {
    
    var userName: String
    var password: String
  
    init?(userName: String, 
          password: String,
          userNameValidator: UserNameValidator? = nil) {
      
    	self.userName = userName
      self.password = password
      
      let validator1 = userNameValidator ?? UserNameValidator()
      if validator1.validate(userName) == false {
        return nil
      }
    }
  }
  ```

- we don't have the UserNameValidator class yet.. now also the production code is broken 

- we need to TDD the UserNameValidator class!

