//
//  DecimalUtils.swift
//  moneyApp
//
//  Created by Vladlens Kukjans on 18/02/2023.
//

import Foundation


extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
