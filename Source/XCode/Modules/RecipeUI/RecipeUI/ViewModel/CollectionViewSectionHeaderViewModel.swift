//
//  CollectionViewSectionHeaderViewModel.swift
//  RecipeBook
//
//  Created by Christian Slanzi on 10.05.21.
//

import Foundation

public protocol CollectionViewSectionHeaderViewModelProtocol {
    func setView(_ view: CollectionViewSectionHeaderProtocol)
    func setup()
}

public class CollectionViewSectionHeaderViewModel {
    
    private var collectionViewSectionHeader: CollectionViewSectionHeaderProtocol?
    
    private var sectionTitle: String?
    
    init?(title: String?) {
        guard let title = title else { return nil }
        self.sectionTitle = title
    }
    
    func setView(_ view: CollectionViewSectionHeaderProtocol) {
        self.collectionViewSectionHeader = view
    }
    
    func setup() {
        
        guard let collectionViewSectionHeader = collectionViewSectionHeader ,
            let sectionTitle = sectionTitle else {
                return
        }
        
        collectionViewSectionHeader.setHeaderText(text: sectionTitle)
    }
}
