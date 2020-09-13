//
//  DirectoryTests.swift
//  FilesTests
//
//  Created by Naruki Chigira on 2020/09/12.
//

import XCTest
@testable import Files

class DirectoryTests: XCTestCase {
    private let testDirectoryName = "test"
    private let testFileName = "sample.txt"

    func testDirectoryCreateAndRemove() throws {
        let tmp = Files.root(.tmp)
        let data = "sample".data(using: .utf8)!

        XCTContext.runActivity(named: "Create directory on tmp directory.") { _ in
            tmp.createDirectory(name: testDirectoryName)
            XCTAssert(tmp.directory(named: testDirectoryName) != nil)
        }

        XCTContext.runActivity(named: "Remove directory on tmp directory.") { _ in
            try? tmp.directory(named: testDirectoryName)?.remove()
            XCTAssert(tmp.directory(named: testDirectoryName) == nil)
        }

        XCTContext.runActivity(named: "Create file on tmp directory.") { _ in
            tmp.createFile(name: testFileName, data: data)
            XCTAssert(tmp.file(named: testFileName) != nil)
        }

        XCTContext.runActivity(named: "Remove file on tmp directory.") { _ in
            try? tmp.file(named: testFileName)?.remove()
            XCTAssert(tmp.file(named: testFileName) == nil)
        }
    }

    func testObserveDirectoryByChildDirectory() {
        let tmp = Files.root(.tmp)
        var observedCount = 0

        tmp.directoryDidChangeHandler = { _ in
            observedCount += 1
        }

        XCTContext.runActivity(named: "Create/Remove directory and increment observed count.") { _ in
            tmp.createDirectory(name: testDirectoryName)
            try? tmp.directory(named: testDirectoryName)?.remove()

            let expectation = self.expectation(description: "Called did change handler.")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0E-3) {
                XCTAssert(observedCount == 2)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 5.0E-3)
        }
    }

    func testObserveDirectoryByFile() {
        let tmp = Files.root(.tmp)
        var observedCount = 0
        let data = "sample".data(using: .utf8)!

        tmp.directoryDidChangeHandler = { _ in
            observedCount += 1
        }

        XCTContext.runActivity(named: "Create/Remove file and increment observed count.") { _ in
            // didChangeHandler called twice here.
            tmp.createFile(name: testFileName, data: data)
            try? tmp.file(named: testFileName)?.remove()

            let expectation = self.expectation(description: "Called did change handler.")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0E-3) {
                XCTAssert(observedCount >= 2)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 5.0E-3)
        }
    }
}
