//
//  SignupViewControllerProtocol.swift
//  CookingApp
//
//  Created by Christian Slanzi on 27.04.21.
//

import Foundation

protocol SignupViewControllerProtocol: class {
    func clearUserNameField()
    func clearPasswordField()
    func clearConfirmPasswordField()
    func enableCancelButton(_ status: Bool)
    func enableCreateButton(_ status: Bool)
    func hideKeyboard()
    
    func showSignupResult(_ result: Bool, error: String?)
}
