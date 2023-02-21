//
//  AccountTests.swift
//  moneyAppUnitTests
//
//  Created by Vladlens Kukjans on 21/02/2023.
//

import Foundation
import XCTest

@testable import moneyApp

class AccountTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
    }
    
    
    func testCanParse() throws {
        let json = """
          [
             {
                     "id": "1",
                     "type": "Banking",
                     "name": "Basic Savings",
                     "amount": 929466.23,
                     "createdDateTime" : "2010-06-21T15:29:32Z"
                   },
                   {
                     "id": "2",
                     "type": "Banking",
                     "name": "No-Fee All-In Chequing",
                     "amount": 17562.44,
                     "createdDateTime" : "2011-06-21T15:29:32Z"
                   },
                ]
        """
        guard  let data = json.data(using: .utf8) else { return }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let result = try decoder.decode([Account].self, from: data)
        
        
        XCTAssertEqual(result.count, 2)
        
        let account1 = result[0]
        XCTAssertEqual(account1.id, "1")
        XCTAssertEqual(account1.type, .Banking)
        XCTAssertEqual(account1.name, "Basic Savings")
        XCTAssertEqual(account1.amount, 929466.23)
        XCTAssertEqual(account1.createdDateTime.monthDayYearString, "Jun 21, 2010")
    }
}
    

