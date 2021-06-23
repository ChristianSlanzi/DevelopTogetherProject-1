//
//  MainViewControllerFactory.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 04.06.21.
//

import NetworkingService
import CocktailsApiService
import CommonUI
import UIKit

protocol MainViewControllerFactory {
    func makeMainViewController() -> UIViewController
}

extension BartenderAppDependencies: MainViewControllerFactory {
    
    typealias CollectionViewAdapter = Adapter<DrinkViewModel, DrinkCellView, HeaderSupplementaryView, NewBannerSupplementaryView, NewBannerSupplementaryView>
    
    func makeMainViewController() -> UIViewController {
        let layout = EnvironmentBasedLayoutBuilder().makeLayout(itemsPerRow: 1, groupHeightDimension: .absolute(200))//.fractionalWidth(fraction)))
        
        let adapter = CollectionViewAdapter()
        adapter.configureCell = { model, cell in
            //TODO
            cell.backgroundColor = .lightGray//self.randomColor()
            cell.title.textColor = .black
            cell.title.text = model.name
        }
        adapter.configureHeader = { model, header in
            header.viewModel = HeaderSupplementaryView.ViewModel(title: model.title)
        }
        adapter.select = { model in
            //TODO
        }
        
        adapter.dataSource = makeDataSource()
        
        let viewController = MainViewController(collectionViewLayout: layout, dataSource: adapter)
        let viewModel = adapter.dataSource as! MainDataSource
        viewModel.view = viewController
        
        viewController.registerCells(type: DrinkCellView.self)
        viewController.registerHeaderSupplementaryView(type: HeaderSupplementaryView.self)
        viewController.registerFooterSupplementaryView(type: NewBannerSupplementaryView.self)
        viewController.setFLowLayoutDelegate(adapter)
        return viewController
    }
    
    func makeDataSource() -> MainDataSource {
        
        let httpClient = URLSessionHTTPClient(session: URLSession(configuration: .default))
        let service = CocktailsApiRemote(url: URL(string: "https://www.thecocktaildb.com/api/json/v1/1")!, client: httpClient)

        let remoteLoader = RemoteCocktailsLoader(service: service)
        let localLoader = LocalCocktailsLoader()
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
