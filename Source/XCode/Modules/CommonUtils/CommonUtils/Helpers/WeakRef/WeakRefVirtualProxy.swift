//
//  WeakRefVirtualProxy.swift
//  CommonUtils
//
//  Created by Christian Slanzi on 16.06.21.
//

public final class WeakRefVirtualProxy<T: AnyObject> {
    public weak var object: T?

    init(_ object: T) {
        self.object = object
    }
}
