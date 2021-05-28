//
//  IngredientsView.swift
//  CookingApp
//
//  Created by Christian Slanzi on 27.05.21.
//

import UIKit
import CommonUI

class IngredientsView: CustomView {
    
    var ingredients: [String] = []
    //var ingredientsLabels: [DefaultLabel] = []
    var stackView: UIStackView = UIStackView(frame: .zero)
    
    func setItems(_ items: [String]) {
        self.ingredients = items
        
//        for ingredient in ingredients {
//            let label = DefaultLabel(title: ingredient)
//            ingredientsLabels.append(label)
//
//            NSLayoutConstraint.activate([
//                label.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
//                preparationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
//                //preparationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
//                preparationLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
//            ])
//        }
        for ingredient in ingredients {
            addEntry(title: ingredient)
        }
    }
    
    private func addEntry(title: String) {
        let stack = stackView
        let index = stack.arrangedSubviews.count - 1
        let addView = stack.arrangedSubviews[index]

        let newView = createEntry(title: title)
        //newView.hidden = true
        stack.insertArrangedSubview(newView, at: index)
    }
    
    private func createEntry(title: String) -> UIView {
        let label = DefaultLabel(title: title)
        return label
    }
    
    override func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        super.setupViews()
        addSubview(stackView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
}
