//
//  BartenderAppDependencies.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 04.06.21.
//

class BartenderAppDependencies: AppDependencies {
    
    static let shared = BartenderAppDependencies()
    
    override func start() {
        super.start()
        
        setRootViewController(makeMainViewController())
    }
}



