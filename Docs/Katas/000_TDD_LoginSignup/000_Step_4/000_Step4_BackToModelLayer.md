# Step 4: Back to Model layer

- add new test function to LoginModelTests

  ```swift
  func testLoginModel_ValidUserName_InvalidPassword_CanNotBeInstantiated() {
    let loginModel = LoginModel(userName: validDummyUserName,
                                password: invalidDummyPassword)
    XCTAssertNil(loginModel)
  }
  ```

- fix the production code

  ```swift
  class LoginModel: NSObject {
    
    var userName: String
    var password: String
  
    init?(userName: String, 
          password: String,
          userNameValidator: UserNameValidator? = nil,
          passwordValidator: PasswordValidator? = nil) {
          
    	let validator1 = userNameValidator ?? UserNameValidator()
      if validator1.validate(userName) == false {
       	return nil
      }
          
      let validator2 = passwordValidator ?? PasswordValidator()
      if validator2.validate(password) == false {
        return nil
      }
          
      self.userName = userName
      self.password = password
          
    }
  }
  ```

- TDD the PasswordValidator or integrate the provided files:
  [PasswordValidatorTests](FilesToAdd/PasswordValidatorTests.swift)

  [PasswordValidator](FilesToAdd/PasswordValidator.swift)

- add more tests

  ```swift
  func testLoginModel_InvalidUserName_InvalidPassword_CanNotBeInstantiated() {
    let loginModel = LoginModel(userName: invalidDummyUserName, 
                                password: invalidDummyPassword)
    XCTAssertNil(loginModel)
  }
  
  func testLoginModel_EmptyUserName_ValidPassword_CanNotBeInstantiated() {
    let loginModel = LoginModel(userName: emptyDummyUserName, 
                                password: validDummyPassword)
    XCTAssertNil(loginModel)
  }
  
  func testLoginModel_EmptyUserName_InvalidPassword_CanNotBeInstantiated() {
    let loginModel = LoginModel(userName: emptyDummyUserName, 
                                password: invalidDummyPassword)
    XCTAssertNil(loginModel)
  }
  
  func testLoginModel_EmptyUserName_EmptyPassword_CanNotBeInstantiated() {
    let loginModel = LoginModel(userName: emptyDummyUserName, 
                                password: emptyDummyPassword)
    XCTAssertNil(loginModel)
  }
  
  func testLoginModel_ValidUserName_EmptyPassword_CanNotBeInstantiated() {
    let loginModel = LoginModel(userName: validDummyUserName, 
                                password: emptyDummyPassword)
    XCTAssertNil(loginModel)
  }
  
  func testLoginModel_InvalidUserName_EmptyPassword_CanNotBeInstantiated() {
    let loginModel = LoginModel(userName: invalidDummyUserName, 
                                password: emptyDummyPassword)
    XCTAssertNil(loginModel)
  }
  ```

- The tests are green, so the TDD of the LoginModel is completed.

- Repeat the same process for the SignupModel class or integrate the provided files (SignupModel, EmailAddressValidatorTests, EmailAddressValidator).

- [EmailAddressValidatorTests](FilesToAdd/EmailAddressValidatorTests.swift)

  [EmailAddressValidator](FilesToAdd/EmailAddressValidator.swift) 

  [SignupModel](FilesToAdd/SignupModel.swift) 

Now your project should look like this:
[Step_4_FinalCode](FinalCode/)

Next step we'll add the ViewModel Layer:

[Step 5](../000_Step_5/000_Step5_ViewModelLayer.md)

