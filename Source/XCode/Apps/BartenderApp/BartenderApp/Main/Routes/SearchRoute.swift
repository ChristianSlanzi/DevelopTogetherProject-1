//
//  SearchRoute.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 15.07.21.
//

import Foundation
import CommonRouting

protocol SearchRoute {
}

extension SearchRoute where Self: Router {
}

extension DefaultRouter: SearchRoute {}

