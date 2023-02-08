//
//  NumberFormatter+Extensions.swift
//  FinalBudgetAppRCP
//
//  Created by Rodney Platt on 1/10/23.
//

import Foundation

extension NumberFormatter {
    
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
}
