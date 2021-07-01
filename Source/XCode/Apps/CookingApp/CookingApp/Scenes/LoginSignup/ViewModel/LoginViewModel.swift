//
//  LoginViewModel.swift
//  CookingApp
//
//  Created by Christian Slanzi on 27.04.21.
//

import Foundation
import LoginSignupModule
import CommonRouting

class LoginViewModel {
    
    typealias Routes = LoginRoute & SignupRoute & MainRoute & Closable
    private var router: Routes?
    
    weak var view: LoginViewControllerProtocol?
    
    var userNameValidator: UserNameValidator?
    var passwordValidator: PasswordValidator?
    var userNameValidated: Bool
    var passwordValidated: Bool
    
    var loginController: LoginController?
    
    init(view: LoginViewControllerProtocol, router: Routes? = nil) {
        self.userNameValidated = false
        self.passwordValidated = false
        self.view = view
        self.router = router
    }
    
    func performInitialViewSetup() {
        view?.clearUserNameField()
        view?.clearPasswordField()
        view?.enableLoginButton(false)
        view?.enableCreateAccountButton(true)
        view?.hideKeyboard()
    }
    
    func userNameDidEndOnExit() {
        view?.hideKeyboard()
    }
    
    func passwordDidEndOnExit() {
        view?.hideKeyboard()
    }
    
    func userNameUpdated(_ value: String?) {
        
        guard let value = value else {
            view?.enableLoginButton(false)
            return
        }
        
        let validator = self.userNameValidator ?? UserNameValidator()
        userNameValidated = validator.validate(value)
        
        if userNameValidated == false {
            view?.enableLoginButton(false)
            return
        }
        
        if passwordValidated == false {
            view?.enableLoginButton(false)
            return
        }
        
        view?.enableLoginButton(true)
    }
    
    func passwordUpdated(_ value: String?) {
        
        guard let value = value else {
            view?.enableLoginButton(false)
            return
        }
        
        let validator = self.passwordValidator ?? PasswordValidator()
        passwordValidated = validator.validate(value)
        
        if passwordValidated == false {
            view?.enableLoginButton(false)
            return
        }
        
        if userNameValidated == false {
            view?.enableLoginButton(false)
            return
        }
        
        view?.enableLoginButton(true)
    }
    
    func login(userName: String?, password: String?) {
        let controller = self.loginController ?? LoginController(delegate: self)
        
        if let userName = userName,
           let password = password,
           let model = LoginModel(userName: userName, password: password) {
            controller.doLogin(model: model)
        }
    }
    
    func createAccount() {
        router?.openSignup()
    }
    
    func openMain() {
        router?.close()
        router?.openMain()
    }
}

extension LoginViewModel: LoginControllerDelegate {
    
    func loginResult(result: Bool, error: String?) {
        // do someting with the result,
        // perhaps segue to a different screen of the app.
        
        // we show an alert as a dummy implementation
        view?.showLoginResult(result, error: error)
    }
    
}
