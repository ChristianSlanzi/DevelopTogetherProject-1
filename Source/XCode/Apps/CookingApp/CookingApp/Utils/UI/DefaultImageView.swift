//
//  DefaultImageView.swift
//  CookingApp
//
//  Created by Christian Slanzi on 24.05.21.
//

import UIKit

class DefaultImageView: UIImageView {
    required init(urlPath: String?, fallback: String, mode: UIView.ContentMode = .scaleAspectFill) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        let fallbackImage = UIImage(named: fallback)
        if let path = urlPath, let url = URL(string: path) {
            load(url: url, fallback: fallbackImage
            )
        } else {
            image = fallbackImage
        }
        contentMode = mode
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
