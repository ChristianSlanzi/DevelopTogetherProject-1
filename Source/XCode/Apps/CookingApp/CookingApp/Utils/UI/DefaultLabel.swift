//
//  DefaultLabel.swift
//  CookingApp
//
//  Created by Christian Slanzi on 24.05.21.
//

import UIKit

class DefaultLabel: UILabel {
    required init(title: String, numOfLines: Int = 0, lineBreak: NSLineBreakMode = .byWordWrapping) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        numberOfLines = numOfLines
        lineBreakMode = lineBreak
        text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
