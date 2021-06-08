//
//  NutrientsSearchView.swift
//  CookingApp
//
//  Created by Christian Slanzi on 07.06.21.
//

import UIKit
import CommonUI

class NutrientsSearchView: CustomView {

    let minCarbs = ValidableTextControl()
    let maxCarbs = ValidableTextControl()
    let minProtein = ValidableTextControl()
    let maxProtein = ValidableTextControl()
    
    var searchButton = DefaultButton(title: "SEARCH BY NUTRIENTS", target: self, selector: #selector(searchButtonTapped))
    
    var viewModel: NutrientsSearchViewModel
    
    init(viewModel: NutrientsSearchViewModel) {
        self.viewModel = viewModel
        super.init()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViews() {
        super.setupViews()
        
        minCarbs.configure(title: "minCarbs", validationRules: [], contentType: .postalCode)
        maxCarbs.configure(title: "maxCarbs", validationRules: [], contentType: .postalCode)
        minProtein.configure(title: "minProtein", validationRules: [], contentType: .postalCode)
        maxProtein.configure(title: "maxProtein", validationRules: [], contentType: .postalCode)
        
        addSubviews(minCarbs, maxCarbs, minProtein, maxProtein, searchButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            minCarbs.safeTopAnchor.constraint(equalTo: safeTopAnchor, constant: 10),
            minCarbs.safeLeadingAnchor.constraint(equalTo: safeLeadingAnchor, constant: 10),
            minCarbs.safeTrailingAnchor.constraint(equalTo: safeTrailingAnchor, constant: -10),
            minCarbs.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            maxCarbs.safeTopAnchor.constraint(equalTo: minCarbs.safeBottomAnchor, constant: 20),
            maxCarbs.safeLeadingAnchor.constraint(equalTo: safeLeadingAnchor, constant: 10),
            maxCarbs.safeTrailingAnchor.constraint(equalTo: safeTrailingAnchor, constant: -10),
            maxCarbs.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            minProtein.safeTopAnchor.constraint(equalTo: maxCarbs.safeBottomAnchor, constant: 20),
            minProtein.safeLeadingAnchor.constraint(equalTo: safeLeadingAnchor, constant: 10),
            minProtein.safeTrailingAnchor.constraint(equalTo: safeTrailingAnchor, constant: -10),
            minProtein.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            maxProtein.safeTopAnchor.constraint(equalTo: minProtein.safeBottomAnchor, constant: 20),
            maxProtein.safeLeadingAnchor.constraint(equalTo: safeLeadingAnchor, constant: 10),
            maxProtein.safeTrailingAnchor.constraint(equalTo: safeTrailingAnchor, constant: -10),
            maxProtein.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            searchButton.safeTopAnchor.constraint(equalTo: maxProtein.safeBottomAnchor, constant: 20),
            searchButton.safeLeadingAnchor.constraint(equalTo: safeLeadingAnchor, constant: 10),
            searchButton.safeTrailingAnchor.constraint(equalTo: safeTrailingAnchor, constant: -10),
            searchButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    override func setupActions() {
        super.setupActions()
        
        minCarbs.textDidChange = { text in
            guard let text = text, let intValue = Int(text) else { return }
            self.viewModel.minCarbsValueUpdated(intValue)
        }
        
        maxCarbs.textDidChange = { text in
            guard let text = text, let intValue = Int(text) else { return }
            self.viewModel.maxCarbsValueUpdated(intValue)
        }
        
        minProtein.textDidChange = { text in
            guard let text = text, let intValue = Int(text) else { return }
            self.viewModel.minProteinValueUpdated(intValue)
        }
        
        maxProtein.textDidChange = { text in
            guard let text = text, let intValue = Int(text) else { return }
            self.viewModel.maxProteinValueUpdated(intValue)
        }
    }
    
    @objc func searchButtonTapped() {
        viewModel.onSearchButtonPressed()
    }
}
