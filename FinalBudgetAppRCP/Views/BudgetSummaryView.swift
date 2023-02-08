//
//  BudgetSummaryView.swift
//  FinalBudgetAppRCP
//
//  Created by Rodney Platt on 1/16/23.
//

import SwiftUI

struct BudgetSummaryView: View {
    
    @ObservedObject var budgetCategory: BudgetCategory
    
    var body: some View {
        VStack {
            Text("\(budgetCategory.overSpent ? "OverSpent" : "Remaining") \(Text(budgetCategory.remainingBudgetTotal as NSNumber, formatter: NumberFormatter.currency))")
                .frame(maxWidth: .infinity)
                .fontWeight(.bold)
                .foregroundColor(budgetCategory.overSpent ? .red: .green)
        }
    }
}


