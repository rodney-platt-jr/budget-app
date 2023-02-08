//
//  BudgetListView.swift
//  FinalBudgetAppRCP
//
//  Created by Rodney Platt on 1/10/23.
//

import SwiftUI

struct BudgetListView: View {
    
    
    let budgetCategoryResults: FetchedResults<BudgetCategory>
    let onDeleteBudgetCategory: (BudgetCategory) -> Void
    let onEditBudgetCategory: (BudgetCategory) -> Void
    
    var body: some View {
        List {
            
            if !budgetCategoryResults.isEmpty {
                
                ForEach(budgetCategoryResults) { budgetCategory in
                    NavigationLink(value: budgetCategory) {
                        HStack {
                            Text(budgetCategory.title ?? "")
                            Spacer()
                            VStack (alignment: .trailing, spacing: 10) {
                                Text(budgetCategory.total as NSNumber, formatter:
                                        NumberFormatter.currency)
                                Text("\(budgetCategory.overSpent ? "OverSpent" : "Remaining") \(Text(budgetCategory.remainingBudgetTotal as NSNumber, formatter: NumberFormatter.currency))")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .fontWeight(.bold)
                                    .foregroundColor(budgetCategory.overSpent ? .red: .green)
                            }
                        }.contentShape(Rectangle())
                            .onLongPressGesture {
                                onEditBudgetCategory(budgetCategory)
                            }
                    }
                }.onDelete { indexSet in
                    indexSet.map { budgetCategoryResults[$0]
                    }.forEach(onDeleteBudgetCategory)
                }
                
            } else {
                Text("No budget categories exist")
            }
        }
        .listStyle(.plain)
        .navigationDestination(for: BudgetCategory.self) { budgetCategory in
            BudgetDetailView(budgetCategory: budgetCategory)
        }
    }
}


