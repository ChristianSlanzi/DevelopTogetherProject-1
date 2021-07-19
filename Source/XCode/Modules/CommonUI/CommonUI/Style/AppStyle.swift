//
//  AppStyle.swift
//  CookingApp
//
//  Created by Christian Slanzi on 18.06.21.
//

import UIKit

public struct AppStyle {
    
    var defaultButtonStyle = DefaultButtonStyle()
    var defaultImageViewStyle = DefaultImageViewStyle()
    
    public struct DefaultButtonStyle {
        var textColor: UIColor = .white
        var backgroundColor: UIColor = .red
        var backgroundImage: UIImage? = nil
        var cornerRadius: CGFloat = 5.0
    }
    
    public struct DefaultImageViewStyle {
        var backgroundColor: UIColor = .white
        var cornerRadius: CGFloat = 10.0
        var contentMode: UIView.ContentMode = .scaleAspectFill
    }
}

// default app style
var appStyle: AppStyle = {
    let style = AppStyle()
    return style
}()
