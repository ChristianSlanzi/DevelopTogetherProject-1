//
//  NewBannerSupplementaryView.swift
//  Photos
//
//  Created by Michael Liberatore on 6/5/20.
//  Copyright © 2020 Lickability. All rights reserved.
//

import UIKit
import CommonUI

/// A supplementary banner view containing the text "NEW".
final class NewBannerSupplementaryView: UICollectionReusableView, Reusable {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
    }
}
