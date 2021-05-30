//
//  CookingTimeView.swift
//  CookingApp
//
//  Created by Christian Slanzi on 27.05.21.
//

import CommonUI
import UIKit

class CookingTimeView: CustomView {
    
    let preparationLabel = DefaultLabel(title: "preparation")
    let cookingLabel = DefaultLabel(title: "cooking")
    
    override func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        super.setupViews()
        
        preparationLabel.font = .systemFont(ofSize: 12)
        cookingLabel.font = .systemFont(ofSize: 12)
        addSubviews(preparationLabel, cookingLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            preparationLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            preparationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            //preparationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            preparationLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            cookingLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            cookingLabel.leadingAnchor.constraint(equalTo: preparationLabel.trailingAnchor, constant: 20),
            cookingLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            cookingLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
}
