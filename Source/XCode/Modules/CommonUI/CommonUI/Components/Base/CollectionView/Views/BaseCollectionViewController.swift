//
//  BaseCollectionViewController.swift
//  MiscProject
//
//  Created by Christian Slanzi on 18.06.21.
//

import UIKit

/// Displays a list of items in a collection view.
open class BaseCollectionViewController: UICollectionViewController {
    private let layout: UICollectionViewLayout
    private let dataSource: UICollectionViewDataSource
      
    // MARK: - NSCoding
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    
    public override func viewDidLoad() {
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = dataSource
        collectionView.reloadData()
    }
    
    // MARK: - Init
    
    public init(collectionViewLayout: UICollectionViewLayout, dataSource: UICollectionViewDataSource) {
        self.layout = collectionViewLayout
        self.dataSource = dataSource
        super.init(collectionViewLayout: collectionViewLayout)
    }
    
    public func registerCells<T: UICollectionViewCell>(type: T.Type) {
        collectionView.register(cell: T.self)
    }
    
    public func registerHeaderSupplementaryView<Header: UICollectionReusableView>(type: Header.Type) where Header: Reusable {
        collectionView.register(header: Header.self)
    }
    
    public func registerFooterSupplementaryView<Footer: UICollectionReusableView>(type: Footer.Type) {
        collectionView.register(footer: Footer.self)
    }
    
    public func registerSupplementaryView<T: UICollectionReusableView>(type: T.Type) where T: Reusable {
        collectionView.registerReusableSupplementaryView(elementKind: "new-banner", T.self)
    }
    
    
    
    public func setFLowLayoutDelegate(_ delegate: UICollectionViewDelegate) {
        collectionView.delegate = delegate
    }
    
    public func reload() {
        collectionView.reloadData()
    }
    /*
    private func registerCells() {
        collectionView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
        collectionView.register(UINib(nibName: "HeaderSupplementaryView", bundle: nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: "HeaderSupplementaryView")
        collectionView.register(UINib(nibName: "NewBannerSupplementaryView", bundle: nil), forSupplementaryViewOfKind: "new-banner", withReuseIdentifier: "NewBannerSupplementaryView")
    }
    */
}
