//
//  SignupViewModel.swift
//  CookingApp
//
//  Created by Christian Slanzi on 27.04.21.
//

import Foundation

class SignupViewModel {
    
    weak var view: SignupViewControllerProtocol?
    
    init(view: SignupViewControllerProtocol) {
 
        self.view = view
    }
}
