//
//  Date + Utils.swift
//  moneyApp
//
//  Created by Vladlens Kukjans on 20/02/2023.
//

import Foundation


extension Date {
    static var moneyAppateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "MDT")
        return formatter
    }
    
    var monthDayYearString: String {
        let dateFormatter = Date.moneyAppateFormatter
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: self)
    }
}
