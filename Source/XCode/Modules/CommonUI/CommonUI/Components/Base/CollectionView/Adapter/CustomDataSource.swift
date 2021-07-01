//
//  CustomDataSource.swift
//  MiscProject
//
//  Created by Christian Slanzi on 21.06.21.
//

import Foundation

/// The data source associated with a list of items.
open class CustomDataSource<Item>: NSObject, DataSourceProtocol {
    open func reloadData() {
        
    }
    
    /// Represents a section in the data source.
    public struct Section {
        
        /// Represents an item in the data source.
//        struct Item {
//
//            /// The unique identifier of the item.
//            let identifier: Int
//
//            /// The title associated with the item.
//            let title: String
//
//            /// The URL for the item’s thumbnail.
//            let thumbnailURL: URL
//        }
        public let title: String
        /// The items that comprise the section.
        let items: [Item]
        
        public init(title: String, items: [Item]) {
            self.title = title
            self.items = items
        }
    }
    
    /// The sections that comprise the data source.
    public var sections: [Section]
    
    /// Describes the ways that items can be distributed across sections.
    public enum SectionStyle {
        
        /// Items are all found in one section.
        case single
        
        /// Items are distributed across multiple sections based on their section identifier.
        case bySection(maximumItemsPerSection: Int?, maximumNumberOfSections: Int?)
    }
    
    /// Creates a new instance of `CustomDataSource`.
    /// - Parameter sections: The sections models that comprise the data source.
    /// - Parameter sectionStyle: How items are distributed across sections.
    public init(sections: [Section], sectionStyle: SectionStyle) {
        self.sections = sections
    }
    
    /*
    /// Creates a new instance of `CustomDataSource`.
    /// - Parameter photos: The photo models that comprise the data source.
    /// - Parameter sectionStyle: How items are distributed across sections.
    init(photos: [Photo], sectionStyle: SectionStyle) {
        switch sectionStyle {
        case .single:
            self.sections = [Section(items: photos.map { Section.Item(identifier: $0.id, title: $0.title, thumbnailURL: $0.thumbnailUrl)})]
            
        case .byAlbum(let maximumItemsPerAlbum, let maximumNumberOfAlbums):
            var sectionNumberToItems: [Int: [Section.Item]] = [:]
            
            for photo in photos {
                let item = Section.Item(identifier: photo.id, title: photo.title, thumbnailURL: photo.thumbnailUrl)
                
                if let existingItems = sectionNumberToItems[photo.albumId] {
                    sectionNumberToItems[photo.albumId] = existingItems + [item]
                } else {
                    sectionNumberToItems[photo.albumId] = [item]
                }
            }
            
            let sortedKeys = sectionNumberToItems.keys.sorted()
            
            var sections: [Section] = []
            for key in Array(sortedKeys.prefix(maximumNumberOfAlbums ?? sortedKeys.count)) {
                guard let items = sectionNumberToItems[key] else { continue }
                sections.append(Section(items: Array(items.prefix(maximumItemsPerAlbum ?? items.count))))
            }
            
            self.sections = sections
        }
        
                
        super.init()
    }
    */
}
