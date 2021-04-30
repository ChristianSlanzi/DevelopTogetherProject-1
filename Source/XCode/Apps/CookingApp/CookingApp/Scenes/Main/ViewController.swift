//
//  ViewController.swift
//  CookingApp
//
//  Created by Christian Slanzi on 27.04.21.
//

import UIKit
import CookingApiService

class ViewController: UIViewController {

    var cookingApiService: CookingApiService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        let label = UILabel(frame: .zero)
        label.text = "Main"
        
        let vStack = UIStackView(arrangedSubviews: [label])
        vStack.axis = .vertical
        vStack.spacing = 8.0

        view.addSubview(vStack)
        vStack.layout.center(in: view)
        
        cookingApiService?.searchRecipes(completion: { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let searchResult):
                print(searchResult.results)
            }
        })
    }


}

