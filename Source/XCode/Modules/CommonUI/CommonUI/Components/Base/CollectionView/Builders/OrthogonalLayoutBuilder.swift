//
//  OrthogonalLayoutBuilder.swift
//  MiscProject
//
//  Created by Christian Slanzi on 21.06.21.
//

import UIKit

public class OrthogonalLayoutBuilder {
    
    public func makeLayout() -> UICollectionViewLayout {
        
        let compositionalLayout: UICollectionViewCompositionalLayout = {
            let inset: CGFloat = 2.5
            
            // Supplementary Item
            let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(30))
            let containerAnchor = NSCollectionLayoutAnchor(edges: [.bottom], absoluteOffset: CGPoint(x: 0, y: -5))
            let supplementaryItem = NSCollectionLayoutSupplementaryItem(layoutSize: layoutSize, elementKind: "new-banner", containerAnchor: containerAnchor)

            // Items
            let largeItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
            let largeItem = NSCollectionLayoutItem(layoutSize: largeItemSize, supplementaryItems: [supplementaryItem])
            largeItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
            
            let smallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
            let smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
            smallItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
            
            // Nested Group
            let nestedGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1))
            let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: nestedGroupSize, subitems: [smallItem])
            
            // Outer Group
            let outerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
            let outerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: outerGroupSize, subitems: [largeItem, nestedGroup, nestedGroup])
            
            // Section
            let section = NSCollectionLayoutSection(group: outerGroup)
            section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset*2, trailing: inset)
            section.orthogonalScrollingBehavior = .groupPaging
            
            // Supplementary Item
            let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
            let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: "header", alignment: .top)
            section.boundarySupplementaryItems = [headerItem]
            
            return UICollectionViewCompositionalLayout(section: section)
        }()
        
        return compositionalLayout
    }
}
