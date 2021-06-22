//
//  CollectionViewController.swift
//  RecipeBook
//
//  Created by Christian Slanzi on 09.05.21.
//

import UIKit

private let cellReuseIdentifier = "CollectionViewCell"
private let headerReuseIdentifier = "CollectionViewSectionHeader"

public class CollectionViewController: UICollectionViewController {
    
    public var viewModel: CollectionViewModel?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        viewModel?.performInitialViewSetup()
        viewModel?.loadData()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    public override func numberOfSections(in collectionView: UICollectionView) -> Int {

        //return 2
        
        guard let viewModel = viewModel else {
            return 0
        }
        
        return viewModel.numberOfSections()
    }


    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        //return 6
        
        guard let viewModel = viewModel else {
            return 0
        }
        
        return viewModel.numberOfItemsInSection(section)
    }

    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath)
        
        //return cell
        
        guard let viewModel = viewModel,
            let collectionViewCell = cell as? CollectionViewCell,
            let cellViewModel = viewModel.cellViewModel(row: indexPath.row, section: indexPath.section) else {
                return cell
        }
        
        collectionViewCell.viewModel = cellViewModel
        cellViewModel.setView(collectionViewCell)
        
        collectionViewCell.setup()
        return collectionViewCell
    }

    public override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifier, for: indexPath)
        
        //return header
        
        guard let viewModel = viewModel,
            let sectionHeader = header as? CollectionViewSectionHeader,
            let sectionHeaderViewModel = viewModel.headerViewModel(section: indexPath.section) else {
                return header
        }
        
        sectionHeader.viewModel = sectionHeaderViewModel
        sectionHeaderViewModel.setView(sectionHeader)
        
        sectionHeader.setup()
        return sectionHeader
    }

}

extension CollectionViewController: CollectionViewControllerProtocol {
    public func reload() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    public func setNavigationTitle(_ title: String) {
        self.title = title
    }
    
    public func setSectionInset(top: Float, left: Float, bottom: Float, right: Float) {
        if let collectionView = self.collectionView,
            let collectionViewLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        }
    }
    
    public func setupCollectionViewCellToUseMaxWidth() {
        if let collectionView = self.collectionView,
            let collectionViewLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.itemSize = CGSize(width: collectionView.bounds.width, height: collectionView.bounds.width * 0.6)
        }
    }
}

// MARK: - UICollectionViewDelegate

extension CollectionViewController {
    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Update selected Assets
        guard let viewModel = viewModel else { return }
        
        viewModel.didSelectItemAt(row: indexPath
                                    .row, section: indexPath.section)
    }
    
    public override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        // Update de-selected Assets
        
    }
}
