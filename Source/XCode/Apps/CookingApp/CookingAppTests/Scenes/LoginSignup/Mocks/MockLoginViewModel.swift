//
//  MockLoginViewModel.swift
//  CookingAppTests
//
//  Created by Christian Slanzi on 27.04.21.
//

import Foundation
import XCTest
@testable import CookingApp

class MockLoginViewModel: LoginViewModel {
    
    var performInitialViewSetupExpectation: XCTestExpectation?
    var userNameDidEndOnExitExpectation: XCTestExpectation?
    
    override func performInitialViewSetup() {
        performInitialViewSetupExpectation?.fulfill()
    }
    
    override func userNameDidEndOnExit() {
        userNameDidEndOnExitExpectation?.fulfill()
    }
}
