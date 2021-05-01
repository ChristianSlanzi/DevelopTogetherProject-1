//
//  SearchViewController.swift
//  CookingApp
//
//  Created by Christian Slanzi on 30.04.21.
//

import UIKit

class SearchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        let label = UILabel(frame: .zero)
        label.text = "Search"
        
        let vStack = UIStackView(arrangedSubviews: [label])
        vStack.axis = .vertical
        vStack.spacing = 8.0

        view.addSubview(vStack)
        vStack.layout.center(in: view)

    }
}
