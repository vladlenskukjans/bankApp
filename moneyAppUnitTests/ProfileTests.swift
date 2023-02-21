//
//  ProfileTests.swift
//  moneyAppUnitTests
//
//  Created by Vladlens Kukjans on 21/02/2023.
//

import Foundation
import XCTest

@testable import moneyApp

class ProfileTests: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
        
    }
    
    func testCanParse() throws {
        let json = """
        {
           "id": "1",
        "first_name": "Kevin",
        "last_name": "Flynn",
        }
        """
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        guard  let data = json.data(using: .utf8) else { return }
        let result = try JSONDecoder().decode(Profile.self, from: data)
        
        XCTAssertEqual(result.id, "1")
        XCTAssertEqual(result.firstName, "Kevin")
        XCTAssertEqual(result.lastName, "Flynn")
        
        
    }
   
  
    
}
