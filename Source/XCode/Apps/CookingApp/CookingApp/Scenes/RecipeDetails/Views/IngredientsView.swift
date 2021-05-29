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
    var stackView: UIStackView = UIStackView(frame: .zero)
    
    func setItems(_ items: [String]) {
        self.ingredients = items
        
        for ingredient in ingredients {
            addEntry(title: ingredient)
        }
        stackView.layoutIfNeeded()
    }
    
    private func addEntry(title: String) {
        let newView = createEntry(title: title)
        stackView.addArrangedSubview(newView)
    }
    
    private func createEntry(title: String) -> UIView {
        let label = DefaultLabel(title: title)
        return label
    }
    
    override func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        super.setupViews()
        addSubview(stackView)
        stackView.axis = .vertical
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
