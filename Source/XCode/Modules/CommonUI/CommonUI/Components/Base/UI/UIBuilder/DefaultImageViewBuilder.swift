//
//  DefaultImageViewBuilder.swift
//  CommonUI
//
//  Created by Christian Slanzi on 28.06.21.
//

import UIKit

public class DefaultImageViewBuilder {
    private var view = DefaultImageView()
    
    public init() {}
    
    public func withAppStyle() -> DefaultImageViewBuilder {
        withStyle(AppStyle.DefaultImageViewStyle())
    }
    
    public func withStyle(_ style: AppStyle.DefaultImageViewStyle)  -> DefaultImageViewBuilder {
        _ = withContentMode(style.contentMode)
        _ = withBackgroundColor(style.backgroundColor)
        _ = withCornerRadius(style.cornerRadius)
        return self
    }
    
    public func withBackgroundColor(_ color: UIColor)  -> DefaultImageViewBuilder {
        view.backgroundColor = color
        return self
    }
    
    public func withCornerRadius(_ radius: CGFloat)  -> DefaultImageViewBuilder {
        view.setCorner(radius: radius)
        return self
    }
    
    public func withContentMode(_ mode: UIView.ContentMode)  -> DefaultImageViewBuilder {
        view.contentMode = mode
        return self
    }
    
    public func build() -> DefaultImageView {
        return view
    }
}
