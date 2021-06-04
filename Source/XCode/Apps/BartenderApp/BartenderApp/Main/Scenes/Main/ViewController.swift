//
//  ViewController.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 03.06.21.
//

import UIKit

class ViewController: UIViewController {

    var viewModel: MainViewModel
    
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
        view.backgroundColor = .systemPink
    
        viewModel.didLoad()
    }
    
}

