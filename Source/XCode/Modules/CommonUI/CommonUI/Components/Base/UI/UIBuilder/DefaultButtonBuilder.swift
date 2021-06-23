//
//  DefaultButtonBuilder.swift
//  CookingApp
//
//  Created by Christian Slanzi on 16.06.21.
//

import UIKit

public class DefaultButtonBuilder {
    private var button = DefaultButton()
    
    public init() {}
    
    public func withAppStyle() -> DefaultButtonBuilder {
        withStyle(AppStyle.DefaultButtonStyle())
    }
    
    public func withStyle(_ style: AppStyle.DefaultButtonStyle)  -> DefaultButtonBuilder {
        _ = withTitleColor(style.textColor)
        _ = withBackgroundColor(style.backgroundColor)
        if let backgroundImage = style.backgroundImage {
            _ = withBackgroundImage(backgroundImage)
        }
        _ = withCornerRadius(style.cornerRadius)
        return self
    }
    
    public func withTitle(_ title: String)  -> DefaultButtonBuilder {
        button.setTitle(title, for: .normal)
        return self
    }
    
    public func withTitleColor(_ color: UIColor)  -> DefaultButtonBuilder {
        button.setTitleColor(color, for: .normal)
        return self
    }
    
    public func withBackgroundColor(_ color: UIColor)  -> DefaultButtonBuilder {
        button.backgroundColor = color
        return self
    }
    
    public func withBackgroundImage(_ image: UIImage)  -> DefaultButtonBuilder {
        button.setBackgroundImage(image, for: .normal)
        return self
    }
    
    public func withCornerRadius(_ radius: CGFloat)  -> DefaultButtonBuilder {
        button.setCorner(radius: radius)
        return self
    }
    
    public func withAction(_ action: Selector, target: Any)  -> DefaultButtonBuilder {
        button.addTarget(target, action: action, for: .touchUpInside)
        return self
    }
    
    public func build() -> DefaultButton {
        return button
    }
}
