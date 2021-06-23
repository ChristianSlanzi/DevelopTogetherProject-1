//
//  SeparatorView.swift
//  CookingApp
//
//  Created by Christian Slanzi on 24.05.21.
//

import UIKit

public class SeparatorView: UIView {
    public required init(color: UIColor = .black) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = color
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
