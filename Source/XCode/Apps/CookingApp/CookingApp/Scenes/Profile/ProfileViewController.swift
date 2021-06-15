//
//  ProfileViewController.swift
//  CookingApp
//
//  Created by Christian Slanzi on 30.04.21.
//

import UIKit
import CommonUI

//////////////////////////////////////////////////////////////////////
// TODO: Move in a UserFeature module

public protocol UserLoader {
    typealias Result = Swift.Result<User, Error>
    func loadUser(_ completion: @escaping (UserLoader.Result) -> Void)
}

public class LocalUserLoader: UserLoader {
    public func loadUser(_ completion: @escaping (UserLoader.Result) -> Void) {
        //TODO
        completion(.success(User(userID: 999, name: "Donald Duck", biography: "born in Paperopoli, millionaire")))
    }
}

public struct User {
    typealias ID = Int

    var userID: ID
    var name: String
    var biography: String
}

//////////////////////////////////////////////////////////////////////

class ProfileViewController: CustomScrollViewController {
    
    private let userID: User.ID
    private let loader: UserLoader
    private lazy var nameLabel = DefaultLabel(title: "Name")
    private lazy var biographyLabel = DefaultLabel(title: "User Biography")
    
    init(userID: User.ID, loader: UserLoader) {
        self.userID = userID
        self.loader = loader
        super.init()
        loadUser()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViews() {
        super.setupViews()
        
        view.backgroundColor = .white
        
        addToContentView(nameLabel, biographyLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
       
        setContentViewTopAnchor(view.safeTopAnchor, padding: 0.0)
        let topAnchor = getContentViewTopAnchor()
        
        let topPadding = CGFloat(35)
        let hPadding = CGFloat(20)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo:
                topAnchor, constant: topPadding),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
        ])
        
        NSLayoutConstraint.activate([
            biographyLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: hPadding),
            biographyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            biographyLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
        ])
        
        setContentViewBottom(view: biographyLabel)
        
    }
    
    private func loadUser() {
        
        loader.loadUser { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.nameLabel.text = user.name
                    self?.biographyLabel.text = user.biography
                case .failure(let error):
                    self?.showError(error)
                }
            }
        }
    }
    
    private func showError(_ error: Error) {
        // TODO
    }

}
