//
//  FlowLayoutBuilder.swift
//  MiscProject
//
//  Created by Christian Slanzi on 21.06.21.
//

import UIKit

public class FlowLayoutBuilder {
    public func makeLayout() -> UICollectionViewLayout {
        let flowLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 5
            layout.minimumLineSpacing = 5
            layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
            return layout
        }()
        return flowLayout
    }
}
