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
        
        view.backgroundColor = .yellow
        
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

