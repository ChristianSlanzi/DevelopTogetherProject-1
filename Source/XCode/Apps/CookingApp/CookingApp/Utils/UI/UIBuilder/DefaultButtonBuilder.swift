//
//  DefaultButtonBuilder.swift
//  CookingApp
//
//  Created by Christian Slanzi on 16.06.21.
//

import UIKit

struct DefaultButtonStyle {
    var textColor: UIColor
    var backgroundColor: UIColor
    var backgroundImage: UIImage?
    var cornerRadius: CGFloat
}

class DefaultButtonBuilder {
    private var button = DefaultButton()
    
    func withStyle(_ style: DefaultButtonStyle)  -> DefaultButtonBuilder {
        _ = withTitleColor(style.textColor)
        _ = withBackgroundColor(style.backgroundColor)
        if let backgroundImage = style.backgroundImage {
            _ = withBackgroundImage(backgroundImage)
        }
        _ = withCornerRadius(style.cornerRadius)
        return self
    }
    
    func withTitle(_ title: String)  -> DefaultButtonBuilder {
        button.setTitle(title, for: .normal)
        return self
    }
    
    func withTitleColor(_ color: UIColor)  -> DefaultButtonBuilder {
        button.setTitleColor(color, for: .normal)
        return self
    }
    
    func withBackgroundColor(_ color: UIColor)  -> DefaultButtonBuilder {
        button.backgroundColor = color
        return self
    }
    
    func withBackgroundImage(_ image: UIImage)  -> DefaultButtonBuilder {
        button.setBackgroundImage(image, for: .normal)
        return self
    }
    
    func withCornerRadius(_ radius: CGFloat)  -> DefaultButtonBuilder {
        button.setCorner(radius: radius)
        return self
    }
    
    func withAction(_ action: Selector, target: Any)  -> DefaultButtonBuilder {
        button.addTarget(target, action: action, for: .touchUpInside)
        return self
    }
    
    func build() -> DefaultButton {
        return button
    }
}
