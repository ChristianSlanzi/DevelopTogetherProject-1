//
//  SearchViewController.swift
//  CookingApp
//
//  Created by Christian Slanzi on 30.04.21.
//

import UIKit
import CommonUI

public protocol CategoriesViewProtocol: class {
    func searchRecipesForCategory(_ cuisine: Cuisine)
}

public protocol NutrientsSearchViewProtocol: class {
    func searchRecipesForNutrients(_ nutrients: [String: Int])
}

class SearchViewController: CustomScrollViewController {
    
    // MARK: - ViewModel
    var viewModel: SearchViewModel
    
    // MARK: - Views
    
    let titleLabel = DefaultLabel(title: "Search")
    let searchView = UISearchBar()
    var categoryView: CategoriesView!
    let ingredientsCheckBox: CheckBox = {
        let view = CheckBox()
        view.translatesAutoresizingMaskIntoConstraints = false
        //cb5.frame = CGRect(x: 25, y: 25, width: 35, height: 35)
        view.style = .tick
        view.borderStyle = .roundedSquare(radius: 5)
        return view
        
    }()
    var nutrientsSearchView: NutrientsSearchView!
    
    // MARK: - Init
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setupViews() {
        super.setupViews()
        
        let categoryViewModel = CategoryViewModel()
        categoryView = CategoriesView(viewModel: categoryViewModel)
        categoryViewModel.view = self
        
        let nutrientsViewModel = NutrientsSearchViewModel()
        nutrientsSearchView = NutrientsSearchView(viewModel: nutrientsViewModel)
        nutrientsViewModel.view = self
        
        view.backgroundColor = .white
                
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.delegate = self
        searchView.searchBarStyle = .minimal
        addToContentView(titleLabel, searchView, ingredientsCheckBox, categoryView, nutrientsSearchView)
        
        
        ingredientsCheckBox.addTarget(self, action: #selector(onCheckBoxValueChange(_:)), for: .valueChanged)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
       
        setContentViewTopAnchor(view.safeTopAnchor, padding: 0.0)
        let topAnchor = getContentViewTopAnchor()
        
        let topPadding = CGFloat(35)
        let hPadding = CGFloat(20)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo:
                topAnchor, constant: topPadding),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
        ])
        
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: hPadding),
            searchView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
        ])
        
        NSLayoutConstraint.activate([
            ingredientsCheckBox.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: hPadding),
            ingredientsCheckBox.leadingAnchor.constraint(equalTo: searchView.leadingAnchor),
            ingredientsCheckBox.widthAnchor.constraint(equalToConstant: 35),
            ingredientsCheckBox.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        NSLayoutConstraint.activate([
            categoryView.topAnchor.constraint(equalTo: ingredientsCheckBox.bottomAnchor, constant: hPadding),
            categoryView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            categoryView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            categoryView.heightAnchor.constraint(equalToConstant: 320)
        ])
        
        NSLayoutConstraint.activate([
            nutrientsSearchView.topAnchor.constraint(equalTo: categoryView.bottomAnchor, constant: hPadding),
            nutrientsSearchView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nutrientsSearchView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            nutrientsSearchView.heightAnchor.constraint(equalToConstant: 320)
        ])

        setContentViewBottom(view: nutrientsSearchView)
    }
    
    @objc func onCheckBoxValueChange(_ sender: CheckBox) {
        
        print(sender.isChecked)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(ingredientsCheckBox.isChecked)
        if ingredientsCheckBox.isChecked {
            viewModel.searchForIngredients(searchBar.text!)
            return
        }
        viewModel.search(searchBar.text!)
    }
}

extension SearchViewController: CategoriesViewProtocol {
    func searchRecipesForCategory(_ cuisine: Cuisine) {
        viewModel.search(cuisine.rawValue)
    }
}

extension SearchViewController: NutrientsSearchViewProtocol {
    func searchRecipesForNutrients(_ nutrients: [String : Int]) {
        viewModel.searchRecipesForNutrients(nutrients)
    }
}
