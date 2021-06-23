//
//  AppStyle.swift
//  CookingApp
//
//  Created by Christian Slanzi on 18.06.21.
//

import UIKit

public struct AppStyle {
    
    var defaultButtonStyle = DefaultButtonStyle()
    
    public struct DefaultButtonStyle {
        var textColor: UIColor = .white
        var backgroundColor: UIColor = .red
        var backgroundImage: UIImage? = nil
        var cornerRadius: CGFloat = 5.0
    }
}

var appStyle: AppStyle = {
    let style = AppStyle()
    
    // default button style

    return style
}()
