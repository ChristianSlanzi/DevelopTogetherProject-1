//
//  SearchViewController.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 15.07.21.
//

import UIKit
import CommonUI

class SearchViewController: CustomScrollViewController {
    
    // MARK: - ViewModel
    var viewModel: SearchViewModel
    
    // MARK: - Views
    
    let titleLabel = DefaultLabel(title: "Search")
    let searchView = UISearchBar()
    
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
        
        view.backgroundColor = .white
                
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.delegate = self
        searchView.searchBarStyle = .minimal
        addToContentView(titleLabel, searchView)
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
        
        setContentViewBottom(view: searchView)
        
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.search(searchBar.text!)
    }
}
