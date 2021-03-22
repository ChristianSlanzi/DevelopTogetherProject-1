//
//  LoginViewControllerProtocol.swift
//  LoginSignupModule
//
//  Created by Christian Slanzi on 22.03.21.
//

import Foundation

protocol LoginViewControllerProtocol: class {
    func clearUserNameField()
    func clearPasswordField()
    func enableLoginButton(_ status: Bool)
    func enableCreateAccountButton(_ status: Bool)
    func hideKeyboard()
}
