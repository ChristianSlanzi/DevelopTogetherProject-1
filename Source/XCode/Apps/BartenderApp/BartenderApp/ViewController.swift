//
//  ViewController.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 03.06.21.
//

import UIKit
import CocktailsApiService
import NetworkingService

class ViewController: UIViewController {

    let httpClient = URLSessionHTTPClient(session: URLSession(configuration: .default))
    var service: CocktailsApiService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemPink
        
        service = CocktailsApiRemote(url: URL(string: "https://www.thecocktaildb.com/api/json/v1/1")!, client: httpClient)
        service.searchCocktailByName("margarita") { [weak self] result in
            guard let self = self else { return }
            
            print(result)
        }
    }
    
}

