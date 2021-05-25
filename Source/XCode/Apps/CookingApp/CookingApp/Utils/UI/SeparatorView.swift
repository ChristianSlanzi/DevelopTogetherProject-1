//
//  SeparatorView.swift
//  CookingApp
//
//  Created by Christian Slanzi on 24.05.21.
//

import UIKit

class SeparatorView: UIView {
    required init(color: UIColor = .black) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
