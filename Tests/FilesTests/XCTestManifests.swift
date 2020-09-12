import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(FilesTests.allTests),
        testCase(ContentTests.allTests)
    ]
}
#endif
