//
//  UIImageView+Ext.swift
//  CookingApp
//
//  Created by Christian Slanzi on 19.05.21.
//

import UIKit

extension UIImageView {
    func load(url: URL, fallback: UIImage?) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        return
                    }
                }
            } else if let image = fallback {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
