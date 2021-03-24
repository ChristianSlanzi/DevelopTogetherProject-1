//
//  SignupViewControllerProtocol.swift
//  LoginSignupModule
//

import Foundation

protocol SignupViewControllerProtocol: class {
    func clearUserNameField()
    func clearPasswordField()
    func clearConfirmPasswordField()
    func enableCancelButton(_ status: Bool)
    func enableCreateButton(_ status: Bool)
    func hideKeyboard()
    func showSignupResult(_ result: Bool)
}
