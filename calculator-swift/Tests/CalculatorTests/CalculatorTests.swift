import XCTest
@testable import Calculator

final class CalculatorTests: XCTestCase {
    func testCalculator() throws {
        let calcSize = CalculatorSize.small
        let calcData = CalculatorData(model: "test", size: calcSize)
        let calc = Calculator(info: calcData)
        let two = calc.add(a: 1, b: 1)
        XCTAssertEqual(two, 2)
    }
}
