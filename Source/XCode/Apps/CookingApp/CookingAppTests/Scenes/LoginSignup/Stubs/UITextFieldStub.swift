//
//  UITextFieldStub.swift
//  CookingAppTests
//
//  Created by Christian Slanzi on 27.04.21.
//

import UIKit

class UITextFieldStub : UITextField {
    
    init(text:String) {
        super.init(frame: CGRect.zero)
        super.text = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
