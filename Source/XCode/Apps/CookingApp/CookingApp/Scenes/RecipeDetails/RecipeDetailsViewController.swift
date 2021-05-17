//
//  RecipeDetailsViewController.swift
//  CookingApp
//
//  Created by Christian Slanzi on 30.04.21.
//

import UIKit

protocol RecipeDetailsViewProtocol: class {
    func setRecipeTitle(_ title: String)
}

class RecipeDetailsViewController: UIViewController {
    
    var viewModel: RecipeDetailsViewModel
    let label = UILabel(frame: .zero)
    
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
        
        
        label.text = "Recipe Details"
        
        let vStack = UIStackView(arrangedSubviews: [label])
        vStack.axis = .vertical
        vStack.spacing = 8.0

        view.addSubview(vStack)
        vStack.layout.center(in: view)
        
        viewModel.viewDidLoad()
    }
}

extension RecipeDetailsViewController: RecipeDetailsViewProtocol {
    func setRecipeTitle(_ title: String) {
        label.text = title
    }
}
