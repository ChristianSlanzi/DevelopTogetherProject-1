//
//  XCTestCase+MemoryLeakTracking.swift
//  UserApiServiceTests
//
//  Created by Christian Slanzi on 23.04.21.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
