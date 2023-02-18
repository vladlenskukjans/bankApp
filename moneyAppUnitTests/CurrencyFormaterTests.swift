//
//  CurrencyFormaterTests.swift
//  moneyAppUnitTests
//
//  Created by Vladlens Kukjans on 18/02/2023.
//

import Foundation
import XCTest

@testable import moneyApp

class Test: XCTestCase {
    var formatter: CurrencyFormatter!
    
    override func setUp() {
        super.setUp()
        formatter = CurrencyFormatter()
        
    }
    
    func testBreakDollarIntoCents() throws {
        let result = formatter.breakIntoDollarsAndCents(929466.23)
        XCTAssertEqual(result.0, "929,466")
        XCTAssertEqual(result.1, "23")
    }
    
     // Challenge: my code
    func testDollarsFormatted() throws {
        let result = formatter.dollarsFormatted(929466.23)
       XCTAssertEqual(result, "$929,466.23")
    }
    
    func testZeroDollarsFormatted() throws {
        let result = formatter.convertCents(0.23)
        XCTAssertEqual(result, "23")
    }
    
    func testDollarsFormattedWithCurrencySymbol() throws {
        let locale = Locale.current
        let currencySymbol = locale.currencySymbol!
        
        let result = formatter.dollarsFormatted(929466.23)
        XCTAssertEqual(result, "\(currencySymbol)929,466.23")
        print("\(currencySymbol)")
    }
    
    
}
