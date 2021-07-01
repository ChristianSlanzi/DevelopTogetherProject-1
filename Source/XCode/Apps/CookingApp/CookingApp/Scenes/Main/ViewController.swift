//
//  ViewController.swift
//  CookingApp
//
//  Created by Christian Slanzi on 27.04.21.
//

import UIKit
import CommonUI

class ViewController: UIViewController {

    private let viewModel: MainViewModel

    init(viewModel: MainViewModel) {
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
        
        let label = UILabel(frame: .zero)
        label.text = "Main"
        
        let recipeButton = DefaultButton(title: "Open a Recipe", target: self, selector: #selector(recipeButtonTouchUpInside))
        
        let vStack = UIStackView(arrangedSubviews: [label, recipeButton])
        vStack.axis = .vertical
        vStack.spacing = 8.0

        view.addSubview(vStack)
        vStack.layout.center(in: view)
        
        viewModel.didLoad()
    }

    @objc
    private func recipeButtonTouchUpInside() {
        viewModel.recipeButtonTouchUpInside()
    }
}

