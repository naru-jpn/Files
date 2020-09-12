//
//  DirectoryTests.swift
//  FilesTests
//
//  Created by Naruki Chigira on 2020/09/12.
//

import XCTest
@testable import Files

class DirectoryTests: XCTestCase {
    func testDirectoryCreateAndRemove() throws {
        let tmp = Files.root(.tmp)
        var directory: Directory?
        var file: File?
        let data = "sample".data(using: .utf8)!

        XCTContext.runActivity(named: "Create directory on tmp directory.") { _ in
            tmp.createDirectory(name: "test")
            directory = tmp.directory(named: "test")
            XCTAssert(directory != nil)
        }

        XCTContext.runActivity(named: "Remove directory on tmp directory.") { _ in
            try? directory?.remove()
            XCTAssert(tmp.directory(named: "test") == nil)
        }

        XCTContext.runActivity(named: "Create file on tmp directory.") { _ in
            tmp.createFile(name: "sample.txt", data: data)
            file = tmp.file(named: "sample.txt")
            XCTAssert(file != nil)
        }

        XCTContext.runActivity(named: "Remove file on tmp directory.") { _ in
            try? file?.remove()
            XCTAssert(tmp.file(named: "sample.txt") == nil)
        }
    }
}
