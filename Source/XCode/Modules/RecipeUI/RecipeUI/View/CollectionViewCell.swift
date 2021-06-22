//
//  CollectionViewCell.swift
//  RecipeBook
//
//  Created by Christian Slanzi on 09.05.21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var cellDetailsLabel: UILabel!
    
    var viewModel: CollectionViewCellViewModel?
    
    func setup() {
        imageView.image = UIImage(named: "cooking_icon", in: Bundle(for: CollectionViewCell.self), with: nil)
        imageView.setCorner(radius: 10)
        viewModel?.setup()
    }
}

extension CollectionViewCell: CollectionViewCellProtocol {
    
    
    func loadImage(resourceName: String) {
        guard let url = URL(string: resourceName) else { return }
        
        imageView.load(url: url)
    }
    
    func setCaption(captionText: String) {
        captionLabel.text = captionText
    }
    
    func setRecipeDetails(recipeDetailsText: String) {
        cellDetailsLabel.text = recipeDetailsText
    }
    
    func setRecipeImage(_ data: Data) {
        imageView.image = UIImage(data: data)
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
