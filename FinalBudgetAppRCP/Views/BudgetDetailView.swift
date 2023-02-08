//
//  BudgetDetailView.swift
//  FinalBudgetAppRCP
//
//  Created by Rodney Platt on 1/13/23.
//

import SwiftUI

import CoreData

struct BudgetDetailView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    let budgetCategory: BudgetCategory
    
    @State private var title: String = ""
    @State private var total: String = ""
    
    
    var isFormValid: Bool {
        guard let totalAsDouble = Double(total) else { return false }
        return !title.isEmpty && !total.isEmpty && totalAsDouble > 0
    }
    
    
    private func saveTransaction() {
        
        do {
            let transaction = Transaction(context: viewContext)
            transaction.title = title
            transaction.total = Double(total)!
            
            budgetCategory.addToTransactions(transaction)
            try viewContext.save()
            
            
            // reset the title and the total
            title = ""
            total = ""
            
        } catch {
            print(error)
            
            //budgetCategory.addToTransactions(transaction)
        }
        
    }
    
    
    private func deleteTransaction(_ transaction: Transaction) {
        viewContext.delete(transaction)
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(budgetCategory.title ?? "")
                        .font(.largeTitle)
                    HStack {
                        Text("Budget:")
                        Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
                    }.fontWeight(.bold)
                }
            }
            
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Total", text: $total)
                } header: {
                    Text("Add Transaction")
                }
                
                
                HStack {
                    Spacer()
                    Button("Save Transaction") {
                        // save transaction
                        saveTransaction()
                    }.disabled(!isFormValid)
                        .buttonStyle(.bordered)
                    Spacer()
                }
                
            }.frame(maxHeight: 300)
                .padding([.bottom], 20)
            
            VStack {
                
                //Display summary of the budget category
                BudgetSummaryView(budgetCategory: budgetCategory)
                
                
                //Display the transaction
                TransactionListView(request: BudgetCategory.transactionsByCategoryRequest(budgetCategory), onDeleteTransaction: deleteTransaction)
            }
            
            
            
            Spacer()
        }.padding()
    }
}

struct BudgetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetDetailView(budgetCategory: BudgetCategory())
    }
}
