import XCTest
@testable import BehindGameKit

final class BehindGameKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(BehindGameKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
