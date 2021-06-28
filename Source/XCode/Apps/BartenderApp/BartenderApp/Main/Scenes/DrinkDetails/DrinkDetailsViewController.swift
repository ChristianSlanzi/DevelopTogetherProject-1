//
//  DrinkDetailsViewController.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 24.06.21.
//

import UIKit
import CommonUI

protocol DrinkDetailsViewProtocol: AnyObject {
    func setDrinkImage(_ imageName: String)
    func setDrinkImage(_ imageData: Data)
    func setDrinkTitle(_ title: String)
    func setDrinkDescription(_ title: String)
    func setDrinkPreparationTime(_ title: String)
    func setDrinkCookingTime(_ title: String)
    func setDrinkIngredients(_ titles: [String])
    func updateFavoriteStatus(_ isFavorite: Bool)
}

class DrinkDetailsViewController: CustomScrollViewController {
    
    // MARK: - ViewModel
    var viewModel: DrinkDetailsViewModel
    
    // MARK: - Views
    
    let itemImageView = DefaultImageView(urlPath: nil, fallback: "drink-placeholder")
    
    //typeLabel (breakfast, lunch, snack, dinner, dessert)
    let typeLabel = DefaultLabel(title: "type")
    
    //categoryLabel (cuisine)
    
    let titleLabel = DefaultLabel(title: "title")
    
    //separatorView
    
    //let descriptionLabel = DefaultLabel(title: "description")
    let instructionsView = InstructionsView(frame: .zero)
    
    //IngredientsView
    let ingredientsView = IngredientsView(frame: .zero)
    
    // MARK: - Init
    
    init(viewModel: DrinkDetailsViewModel) {
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
        //navigationController?.navigationBar
        
        //views
        titleLabel.text = "Recipe Details"
        
        //ingredientsView.backgroundColor = .yellow
        
        addToContentView(itemImageView,
                         titleLabel,
                         instructionsView,
                         ingredientsView)
//                        ,
//                         cookingTimeView
//                         )
        
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
                topAnchor, constant: hPadding),
            itemImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            itemImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: topPadding),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
        ])
        
        NSLayoutConstraint.activate([
            instructionsView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: topPadding),
            instructionsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            instructionsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
        ])
        
//        NSLayoutConstraint.activate([
//            cookingTimeView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: topPadding),
//            cookingTimeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            cookingTimeView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
//            cookingTimeView.heightAnchor.constraint(equalToConstant: 30)
//        ])
//
        
        NSLayoutConstraint.activate([
            ingredientsView.topAnchor.constraint(equalTo: instructionsView.bottomAnchor, constant: topPadding),
            ingredientsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ingredientsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
        
        setContentViewBottom(view: ingredientsView)
        
    }
    
    @objc func favoriteButtonTapped() {
        viewModel.toggleFavoriteStatus()
    }
}

extension DrinkDetailsViewController: DrinkDetailsViewProtocol {
    func setDrinkImage(_ imageName: String) {
        
    }
    
    func setDrinkImage(_ imageData: Data) {
        let image = UIImage(data: imageData)
        itemImageView.image = image
    }
    
    func setDrinkTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func setDrinkDescription(_ text: String) {
        instructionsView.setItems([text])
        //descriptionLabel.attributedText = text.htmlToAttributedString
    }
    
    func setDrinkPreparationTime(_ text: String) {
        
    }
    
    func setDrinkCookingTime(_ text: String) {
        
    }
    
    func setDrinkIngredients(_ titles: [String]) {
        ingredientsView.setItems(titles)
    }
    
    func updateFavoriteStatus(_ isFavorite: Bool) {
        let tintColor: UIColor = isFavorite ? .red : .black
        let favoriteImage = UIImage(named: "favorite_icon", in: Bundle(for: Self.self), with: nil)?.withTintColor(tintColor, renderingMode: .alwaysOriginal)
        let favoriteButton = UIBarButtonItem(image: favoriteImage, style: .plain, target: self, action: #selector(favoriteButtonTapped))
        //let favoriteButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(favoriteButtonTapped))
        navigationItem.rightBarButtonItem = favoriteButton
    }
}
