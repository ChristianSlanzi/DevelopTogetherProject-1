//
//  ViewController.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 03.06.21.
//

import UIKit
import CommonUI

public protocol ViewControllerProtocol: AnyObject {
    func reload()
}

class ViewController: BaseViewController {
    
    let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init()
        self.viewModel.view = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func setupViews() {
        super.setupViews()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CocktailCell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubviews(tableView)
        viewModel.didLoad()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            tableView.safeTopAnchor.constraint(equalTo: view.safeTopAnchor),
            tableView.safeLeadingAnchor.constraint(equalTo: view.safeLeadingAnchor),
            tableView.safeTrailingAnchor.constraint(equalTo: view.safeTrailingAnchor),
            tableView.safeBottomAnchor.constraint(equalTo: view.safeBottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDelegate {
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CocktailCell", for: indexPath)
        cell.textLabel?.text = viewModel.cellViewModel(row: indexPath.row, section: indexPath.section)?.name
        return cell
    }
}

extension ViewController: ViewControllerProtocol {
    func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

