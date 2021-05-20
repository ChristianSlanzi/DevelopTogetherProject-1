//
//  RecipeDetailsViewController.swift
//  CookingApp
//
//  Created by Christian Slanzi on 30.04.21.
//

import UIKit

protocol RecipeDetailsViewProtocol: class {
    func setRecipeImage(_ imageName: String)
    func setRecipeTitle(_ title: String)
    func setRecipeDescription(_ title: String)
}

class RecipeDetailsViewController: UIViewController {
    
    // MARK: - ViewModel
    var viewModel: RecipeDetailsViewModel
    
    // MARK: - Views
    
    //itemImageView
    let itemImageView = UIImageView()
    
    //typeLabel (breakfast, lunch, snack, dinner, dessert)
    var typeLabel: UILabel!
    //categoryLabel (cuisine)
    //titleLabel
    let titleLabel = UILabel(frame: .zero)
    //separatorView
    //descriptionLabel
    let descriptionLabel = UILabel(frame: .zero)
    //CookingTimeView
    //IngredientsView
    //addToGroceryListButton
    
    
    
    // MARK: - Init
    
    init(viewModel: RecipeDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        //navigation
        navigationController?.navigationBar
        
        //views
        titleLabel.text = "Recipe Details"
        itemImageView.image = UIImage(named: "cooking_icon", in: Bundle(for: Self.self), with: nil)
        
        let vStack = UIStackView(arrangedSubviews: [itemImageView, titleLabel, descriptionLabel])
        vStack.axis = .vertical
        vStack.spacing = 8.0

        view.addSubview(vStack)
        vStack.layout.center(in: view)
        
        viewModel.viewDidLoad()
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
