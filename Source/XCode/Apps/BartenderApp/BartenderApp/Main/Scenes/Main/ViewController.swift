//
//  ViewController.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 03.06.21.
//

import UIKit
import CocktailsApiService

class ViewController: UIViewController {

    var service: CocktailsApiService
    
    init(service: CocktailsApiService) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemPink
        
        
        
//        service.searchCocktailByName("margarita") { [weak self] result in
//            guard let self = self else { return }
//
//            print(result)
//        }
        
        service.searchCocktailsByFirstLetter("m") { [weak self] result in
            guard let self = self else { return }
            
            print(result)
        }
    }
    
}

