//
//  MainQueueDispatchDecorator.swift
//  CommonUtils
//
//  Created by Christian Slanzi on 16.06.21.
//

import Foundation

public final class MainQueueDispatchDecorator<T> {

    public let decoratee: T

    init(decoratee: T) {
        self.decoratee = decoratee
    }

    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else {
            DispatchQueue.main.async(execute: completion)
            return
        }
        completion()
    }
}
