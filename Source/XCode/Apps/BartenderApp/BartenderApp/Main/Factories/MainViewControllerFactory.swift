//
//  MainViewControllerFactory.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 04.06.21.
//

import UIKit
import CommonUI
import CommonRouting

protocol MainViewControllerFactory {
    func makeMainViewController() -> UIViewController
}

extension BartenderAppDependencies: MainViewControllerFactory {
    
    
    typealias CollectionViewAdapter = Adapter<Drink, DrinkCellView, HeaderSupplementaryView, NewBannerSupplementaryView, NewBannerSupplementaryView>
    
    func makeMainViewController() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let layout = EnvironmentBasedLayoutBuilder().makeLayout(itemsPerRow: 1, groupHeightDimension: .absolute(200))//.fractionalWidth(fraction)))
        
        let adapter = CollectionViewAdapter()
        adapter.configureCell = { model, cell in
            //TODO
            cell.backgroundColor = .lightGray//self.randomColor()
            cell.title.textColor = .black
            cell.title.text = model.name
            
            if let url = URL(string: model.strDrinkThumb) {
                _ = self.imageDataLoader.loadImageData(from:  url) { result in
                    switch result {
                    case let .failure(error):
                        print(error)
                    case let .success(data):
                        cell.imageView.loadImageData(data)
                    }
                }
            }
        }
        adapter.configureHeader = { model, header in
            header.viewModel = HeaderSupplementaryView.ViewModel(title: model.title)
        }
        adapter.select = { model in
            //TODO
            router.showDrinkDetails(model)
        }
        
        adapter.dataSource = makeDataSource()
        
        let viewController = MainViewController(collectionViewLayout: layout, dataSource: adapter)
        
        let viewModel = adapter.dataSource as! MainDataSource
        viewModel.view = viewController
        
        viewController.registerCells(type: DrinkCellView.self)
        viewController.registerHeaderSupplementaryView(type: HeaderSupplementaryView.self)
        viewController.registerFooterSupplementaryView(type: NewBannerSupplementaryView.self)
        viewController.setFLowLayoutDelegate(adapter)
        
        router.root = viewController
        
        return viewController
    }
    
    func makeDataSource() -> MainDataSource {
    
        let remoteLoader = RemoteCocktailsLoader(service: makeCocktailsApiService())
        let localLoader = LocalCocktailsLoader(store: getDrinkStore(), currentDate: { Date() })
        let compositeFallbackLoader = CompositeFallbackCocktailsLoader(remote: remoteLoader, local: localLoader)
        
        //let viewModel = MainViewModel(loader: compositeFallbackLoader)
        
        let dataSource = MainDataSource(loader: compositeFallbackLoader)
        return dataSource
    }
}

class MainViewModelDecorator: NSObject, UICollectionViewDataSource {
    
    let viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
