//
//  FilesTests.swift
//  FilesTests
//
//  Created by Naruki Chigira on 2020/09/12.

import XCTest
@testable import Files

final class FilesTests: XCTestCase {
    func testGetRoots() {
        let roots = Files.Root.allCases
        for root in roots {
            XCTContext.runActivity(named: "Check exist \(root)") { _ in
                XCTAssertTrue(Files.root(root).isExist)
            }
        }
    }

    static var allTests = [
        ("testGetRoots", testGetRoots),
    ]
}
