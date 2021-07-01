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
    func setDrinkCategory(_ title: String)
    func setDrinkIBA(_ title: String?)
    func setDrinkAlcoholic(_ title: String)
    func setDrinkGlass(_ title: String)
    func setDrinkPreparationTime(_ title: String)
    func setDrinkIngredients(_ titles: [String])
    func updateFavoriteStatus(_ isFavorite: Bool)
}

class DrinkDetailsViewController: CustomScrollViewController {
    
    // MARK: - ViewModel
    var viewModel: DrinkDetailsViewModel
    
    // MARK: - Views
    
    let itemImageView = DefaultImageView(urlPath: nil, fallback: "drink-placeholder")
    
    let categoryLabel = DefaultLabel(title: "Category")
    let ibaLabel = DefaultLabel(title: "IBA")
    let alcoholicLabel = DefaultLabel(title: "Alcoholic")
    let glassLabel = DefaultLabel(title: "Glass")
        
    let titleLabel = DefaultLabel(title: "Title")
    
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
                
        addToContentView(itemImageView,
                         titleLabel,
                         categoryLabel,
                         ibaLabel,
                         alcoholicLabel,
                         glassLabel,
                         instructionsView,
                         ingredientsView)
        
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
            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: topPadding),
            categoryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            categoryLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
        ])
        
        NSLayoutConstraint.activate([
            ibaLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: topPadding),
            ibaLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ibaLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
        ])
        
        NSLayoutConstraint.activate([
            alcoholicLabel.topAnchor.constraint(equalTo: ibaLabel.bottomAnchor, constant: topPadding),
            alcoholicLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alcoholicLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
        ])
        
        NSLayoutConstraint.activate([
            glassLabel.topAnchor.constraint(equalTo: alcoholicLabel.bottomAnchor, constant: topPadding),
            glassLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            glassLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
        ])
        
        NSLayoutConstraint.activate([
            instructionsView.topAnchor.constraint(equalTo: glassLabel.bottomAnchor, constant: topPadding),
            instructionsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            instructionsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
        ])
        
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
    func setDrinkGlass(_ title: String) {
        glassLabel.text = title
    }
    
    func setDrinkIBA(_ title: String?) {
        ibaLabel.text = title
    }
    
    func setDrinkAlcoholic(_ title: String) {
        alcoholicLabel.text = title
    }
    
    func setDrinkCategory(_ title: String) {
        categoryLabel.text = title
    }
    
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
