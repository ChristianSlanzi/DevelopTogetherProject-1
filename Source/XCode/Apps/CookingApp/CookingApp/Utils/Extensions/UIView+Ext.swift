//
//  UIView+Ext.swift
//  CookingApp
//
//  Created by Christian Slanzi on 19.05.21.
//

import UIKit

/// Add an array of subviews to a SuperView
public extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
