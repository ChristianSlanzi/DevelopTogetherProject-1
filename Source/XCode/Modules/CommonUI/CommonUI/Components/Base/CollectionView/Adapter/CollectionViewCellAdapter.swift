//
//  CollectionViewCellAdapter.swift
//  MiscProject
//
//  Created by Christian Slanzi on 18.06.21.
//

import UIKit

public final class Adapter<T,
                           Cell: UICollectionViewCell,
                           Header: UICollectionReusableView,
                           Footer: UICollectionReusableView,
                           Banner: UICollectionReusableView>: NSObject,
                                                              UICollectionViewDataSource,
                                                              UICollectionViewDelegateFlowLayout {

    public var dataSource: CustomDataSource<T>!
    public var configureCell: ((T, Cell) -> Void)?
    public var configureHeader: ((CustomDataSource<T>.Section, Header) -> Void)?
    public var configureFooter: ((CustomDataSource<T>.Section, Footer) -> Void)?
    public var select: ((T) -> Void)?
    public var cellWidth: CGFloat = 60
    public var cellHeight: CGFloat = 60
    public var numberOfItemsPerRow: CGFloat = 3
    
    // MARK: - UICollectionViewDataSource
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.sections.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.sections[section].items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = dataSource.sections[indexPath.section].items[indexPath.item]
        
        let cell: Cell = collectionView.dequeue(indexPath: indexPath)
        configureCell?(item, cell)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = dataSource.sections[indexPath.section].items[indexPath.item]
        select?(item)
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case "header":
            let section = dataSource.sections[indexPath.section]
            let header: Header = collectionView.dequeueHeader(for: indexPath)
            configureHeader?(section, header)
            //headerView.viewModel = HeaderSupplementaryView.ViewModel(title: "Section \(indexPath.section + 1)")
            return header
            
        case "footer":
            let section = dataSource.sections[indexPath.section]
            let footer: Footer = collectionView.dequeueFooter(for: indexPath)
            configureFooter?(section, footer)
            return footer
            
        case "new-banner":
//            let bannerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "NewBannerSupplementaryView", for: indexPath)
//            bannerView.isHidden = indexPath.row % 5 != 0 // show on every 5th item
            let banner: Banner = collectionView.dequeueReusableSupplementaryView(ofKind: "new-banner", withReuseIdentifier: Banner.reuseIdentifier, for: indexPath) as! Banner
            //configureFooter?(section, footer)
            return banner
            
        default:
            assertionFailure("Unexpected element kind: \(kind).")
            return UICollectionReusableView()
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let spacing = (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
        let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
        let itemDimension = floor(availableWidth / numberOfItemsPerRow)
        return CGSize(width: itemDimension, height: cellHeight)
    }
}
/*
/// A generic adapter to act as convenient DataSource and Delegate for UICollectionView
public final class Adapter<T, Cell: UICollectionViewCell>: NSObject,
                                                           UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    public var dataSource: CustomDataSource<T>!
    public var configure: ((T, Cell) -> Void)?
    public var configureSection: ((T, Cell) -> Void)?
    public var select: ((T) -> Void)?
    public var cellWidth: CGFloat = 60
    public var cellHeight: CGFloat = 60
    public var numberOfItemsPerRow: CGFloat = 3
    
    // MARK: - UICollectionViewDataSource
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.sections.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.sections[section].items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = dataSource.sections[indexPath.section].items[indexPath.item]
        
        let cell: Cell = collectionView.dequeue(indexPath: indexPath)
        configure?(item, cell)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = dataSource.sections[indexPath.section].items[indexPath.item]
        select?(item)
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case "header":
//            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderSupplementaryView", for: indexPath) as? HeaderSupplementaryView else {
//                return HeaderSupplementaryView()
//            }
            let headerView: HeaderSupplementaryView = collectionView.dequeueHeader(for: indexPath)
                /*
                as? HeaderSupplementaryView else {
                return HeaderSupplementaryView()
            }*/
            
            headerView.viewModel = HeaderSupplementaryView.ViewModel(title: "Section \(indexPath.section + 1)")
            return headerView
            
        case "new-banner":
            let bannerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "NewBannerSupplementaryView", for: indexPath)
            bannerView.isHidden = indexPath.row % 5 != 0 // show on every 5th item
            return bannerView
            
        default:
            assertionFailure("Unexpected element kind: \(kind).")
            return UICollectionReusableView()
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let spacing = (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
        let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
        let itemDimension = floor(availableWidth / numberOfItemsPerRow)
        return CGSize(width: itemDimension, height: cellHeight)
    }
}
*/
