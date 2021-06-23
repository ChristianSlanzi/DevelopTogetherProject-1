//
//  DrinkCellView.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 23.06.21.
//

import UIKit

class DrinkCellView: UICollectionViewCell {
    
    let title: UILabel = {
        let label = UILabel()
        label.text = "TestCell Title"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        layer.masksToBounds = true
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(title)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor),
            title.leftAnchor.constraint(equalTo: leftAnchor),
            title.rightAnchor.constraint(equalTo: rightAnchor),
            title.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
