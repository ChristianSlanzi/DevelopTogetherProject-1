//
//  RecipeDetailsViewController.swift
//  CookingApp
//
//  Created by Christian Slanzi on 30.04.21.
//

import UIKit
import CommonUI

protocol RecipeDetailsViewProtocol: class {
    func setRecipeImage(_ imageName: String)
    func setRecipeTitle(_ title: String)
    func setRecipeDescription(_ title: String)
}

class RecipeDetailsViewController: CustomScrollViewController {
    
    // MARK: - ViewModel
    var viewModel: RecipeDetailsViewModel
    
    // MARK: - Views
    
    //itemImageView
    let itemImageView: UIImageView = {
        let image = UIImage(named: "cooking_icon")
        let view = UIImageView()
        view.image = image
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //typeLabel (breakfast, lunch, snack, dinner, dessert)
    var typeLabel: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        return view
    }()
    //categoryLabel (cuisine)
    //titleLabel
    let titleLabel: UILabel = {
        let view = UILabel()
         view.translatesAutoresizingMaskIntoConstraints = false
         view.numberOfLines = 0
         view.lineBreakMode = .byWordWrapping
         return view
     }()
    //separatorView
    //descriptionLabel
    let descriptionLabel: UILabel = {
        let view = UILabel()
         view.translatesAutoresizingMaskIntoConstraints = false
         view.numberOfLines = 0
         view.lineBreakMode = .byWordWrapping
         return view
     }()
    //CookingTimeView
    //IngredientsView
    //addToGroceryListButton
    
    
    
    // MARK: - Init
    
    init(viewModel: RecipeDetailsViewModel) {
        self.viewModel = viewModel
        //super.init(nibName: nil, bundle: nil)
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViews() {
        super.setupViews()
        
        view.backgroundColor = .white
        
        //navigation
        navigationController?.navigationBar
        
        //views
        titleLabel.text = "Recipe Details"
        
        addToContentView(itemImageView,
                         titleLabel,
                         descriptionLabel)
        
        //itemImageView.image = UIImage(named: "cooking_icon", in: Bundle(for: Self.self), with: nil)
        
        viewModel.viewDidLoad()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        setContentViewTopAnchor(view.safeTopAnchor)
        let topAnchor = getContentViewTopAnchor()
        let leadingAnchor = getContentViewLeadingAnchor()
        let trailingAnchor = getContentViewTrailingAnchor()
        let bottomAnchor = getContentViewBottomAnchor()
        
        let topPadding = CGFloat(35)
        let hPadding = CGFloat(20)
        let fieldHeight = CGFloat(30)
        let textHeight = CGFloat(90)
        
        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo:
                topAnchor, constant: 0),
            itemImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            //itemImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: topPadding),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            //titleLabel.heightAnchor.constraint(equalToConstant: fieldHeight)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: topPadding),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            //descriptionLabel.heightAnchor.constraint(equalToConstant: fieldHeight)
        ])
        
        setContentViewBottom(view: descriptionLabel)
        
    }
    
}

extension RecipeDetailsViewController: RecipeDetailsViewProtocol {
    
    func setRecipeImage(_ imageName: String) {
        let fallbackImage = UIImage(named: "cooking_icon", in: Bundle(for: Self.self), with: nil)
        guard let url = URL(string: imageName) else {
            itemImageView.image = fallbackImage
            return
        }
        itemImageView.load(url: url, fallback: fallbackImage)
    }
    
    func setRecipeTitle(_ text: String) {
        titleLabel.text = text
    }
    
    func setRecipeDescription(_ text: String) {
        descriptionLabel.text = text
    }
}
