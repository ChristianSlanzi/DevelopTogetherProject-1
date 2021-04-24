//
//  LoginModelSpecs.swift
//  LoginSignupModuleTests
//
//  Created by Christian Slanzi on 24.04.21.
//

import Foundation

protocol LoginModelSpecs {
    func testLoginModel_ValidUserName_ValidPassword_CanBeInstantiated() throws
    func testLoginModel_InvalidUserName_ValidPassword_CanNotBeInstantiated() throws
    func testLoginModel_ValidUserName_InvalidPassword_CanNotBeInstantiated() throws
    func testLoginModel_InvalidUserName_InvalidPassword_CanNotBeInstantiated() throws
    func testLoginModel_EmptyUserName_ValidPassword_CanNotBeInstantiated() throws
    func testLoginModel_EmptyUserName_InvalidPassword_CanNotBeInstantiated() throws
    func testLoginModel_EmptyUserName_EmptyPassword_CanNotBeInstantiated() throws
    func testLoginModel_ValidUserName_EmptyPassword_CanNotBeInstantiated() throws
    func testLoginModel_InvalidUserName_EmptyPassword_CanNotBeInstantiated() throws
}
