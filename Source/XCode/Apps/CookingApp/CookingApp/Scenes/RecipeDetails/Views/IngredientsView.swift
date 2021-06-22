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
    
    var titleLabel = DefaultLabel(title: "Ingredients")
    var stackView: UIStackView = UIStackView(frame: .zero)
    
    var addToGroceryButton = DefaultButtonBuilder()
        .withAppStyle()//.default
        .withTitle("ADD TO GROCERY LIST")
        .withAction(#selector(addToGroceryButtonTouchUpInside), target: self)
        .build()
        
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
        titleLabel.font = .boldSystemFont(ofSize: 18)
        addToGroceryButton.backgroundColor = .red
        addToGroceryButton.setTitleColor(.white, for: .normal)
        addSubviews(titleLabel, stackView, addToGroceryButton)
        stackView.axis = .vertical
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        ])
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
            ,
            stackView.bottomAnchor.constraint(equalTo: addToGroceryButton.topAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            addToGroceryButton.heightAnchor.constraint(equalToConstant: 30),
            addToGroceryButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            addToGroceryButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            addToGroceryButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
    
    @objc
    private func addToGroceryButtonTouchUpInside() {
        // delegate to the view controller?
    }
}
