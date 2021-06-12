//
//  RecipeDetailsViewController.swift
//  CookingApp
//
//  Created by Christian Slanzi on 30.04.21.
//

import UIKit
import CommonUI

protocol RecipeDetailsViewProtocol: AnyObject {
    func setRecipeImage(_ imageName: String)
    func setRecipeTitle(_ title: String)
    func setRecipeDescription(_ title: String)
    func setRecipePreparationTime(_ title: String)
    func setRecipeCookingTime(_ title: String)
    func setRecipeIngredients(_ titles: [String])
    func updateFavoriteStatus(_ isFavorite: Bool)
}

class RecipeDetailsViewController: CustomScrollViewController {
    
    // MARK: - ViewModel
    var viewModel: RecipeDetailsViewModel
    
    // MARK: - Views
    
    let itemImageView = DefaultImageView(urlPath: nil, fallback: "cooking_icon")
    
    //typeLabel (breakfast, lunch, snack, dinner, dessert)
    let typeLabel = DefaultLabel(title: "type")
    
    //categoryLabel (cuisine)
    
    let titleLabel = DefaultLabel(title: "title")
    
    //separatorView
    
    let descriptionLabel = DefaultLabel(title: "description")
    
    //CookingTimeView
    let cookingTimeView = CookingTimeView(frame: .zero)
    
    //IngredientsView
    let ingredientsView = IngredientsView(frame: .zero)
    //addToGroceryListButton
    
    // MARK: - Init
    
    init(viewModel: RecipeDetailsViewModel) {
        self.viewModel = viewModel
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
        
        //ingredientsView.backgroundColor = .yellow
        
        addToContentView(itemImageView,
                         titleLabel,
                         descriptionLabel,
                         cookingTimeView,
                         ingredientsView)
        
        viewModel.viewDidLoad()
        
        let favoriteImage = UIImage(named: "favorite_icon", in: Bundle(for: Self.self), with: nil)?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let favoriteButton = UIBarButtonItem(image: favoriteImage, style: .plain, target: self, action: #selector(favoriteButtonTapped))
        //let favoriteButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(favoriteButtonTapped))
        navigationItem.rightBarButtonItem = favoriteButton
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
                topAnchor, constant: hPadding),
            itemImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: topPadding),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: topPadding),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
        ])
        
        NSLayoutConstraint.activate([
            cookingTimeView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: topPadding),
            cookingTimeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cookingTimeView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            cookingTimeView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            ingredientsView.topAnchor.constraint(equalTo: cookingTimeView.bottomAnchor, constant: topPadding),
            ingredientsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ingredientsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
        
        setContentViewBottom(view: ingredientsView)
        
    }
    
    @objc func favoriteButtonTapped() {
        viewModel.toggleFavoriteStatus()
    }
    
}

extension RecipeDetailsViewController: RecipeDetailsViewProtocol {
    func updateFavoriteStatus(_ isFavorite: Bool) {
        let tintColor: UIColor = isFavorite ? .red : .black
        let favoriteImage = UIImage(named: "favorite_icon", in: Bundle(for: Self.self), with: nil)?.withTintColor(tintColor, renderingMode: .alwaysOriginal)
        let favoriteButton = UIBarButtonItem(image: favoriteImage, style: .plain, target: self, action: #selector(favoriteButtonTapped))
        //let favoriteButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(favoriteButtonTapped))
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
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
        descriptionLabel.attributedText = text.htmlToAttributedString
    }
    
    func setRecipePreparationTime(_ text: String) {
        cookingTimeView.preparationLabel.text = text
    }
    
    func setRecipeCookingTime(_ text: String) {
        cookingTimeView.cookingLabel.text = text
    }
    
    func setRecipeIngredients(_ titles: [String]) {
        ingredientsView.setItems(titles)
    }
}
