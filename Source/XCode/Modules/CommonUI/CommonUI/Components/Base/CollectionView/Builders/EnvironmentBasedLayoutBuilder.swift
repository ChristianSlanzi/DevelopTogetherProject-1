//
//  EnvironmentBasedLayoutBuilder.swift
//  MiscProject
//
//  Created by Christian Slanzi on 22.06.21.
//

import UIKit

public class EnvironmentBasedLayoutBuilder {
    
    public init() {}
    
    public func makeLayout(itemsPerRow: Int, groupHeightDimension: NSCollectionLayoutDimension) -> UICollectionViewLayout {
        let compositionalLayout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            let itemsPerRow = environment.traitCollection.horizontalSizeClass == .compact ? itemsPerRow : itemsPerRow*2
            let fraction: CGFloat = 1 / CGFloat(itemsPerRow)
            let inset: CGFloat = 2.5
            
            // Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
            
            // Group
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(fraction))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
            
            // Supplementary Item
            let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
            let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: "header", alignment: .top)
            section.boundarySupplementaryItems = [headerItem]
            
            return section
        })
        
        return compositionalLayout
    }
}
