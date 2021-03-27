//
//  LoginViewControllerProtocol.swift
//  LoginSignupModule
//

import Foundation

protocol LoginViewControllerProtocol: class {
    func clearUserNameField()
    func clearPasswordField()
    func enableLoginButton(_ status: Bool)
    func enableCreateAccountButton(_ status: Bool)
    func hideKeyboard()
}
