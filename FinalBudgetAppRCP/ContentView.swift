//
//  ContentView.swift
//  FinalBudgetAppRCP
//
//  Created by Rodney Platt on 1/6/23.
//

import SwiftUI
import CoreData

enum SheetAction: Identifiable {
    var id: Int {
    case .edit(_):
        return 2
        }
    }
}
struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: BudgetCategory.all) var budgetCategoryResults
    @State private var sheetAction: SheetAction?
    
    @State private var isPresented: Bool = false
    
    var total: Double {
        budgetCategoryResults.reduce(0) { result, budgetCategory in
            return result + budgetCategory.total
            
        }
    }
    
    private func deleteBudgetCategory(budgetCategory: BudgetCategory) {
        viewContext.delete(budgetCategory)
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    
    private func editBudgetCategory(budgetCategory: BudgetCategory) {
        sheetAction = .edit(budgetCategory)
        
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                
                HStack {
                    Text("Total Budget - ")
                    Text(total as NSNumber, formatter: NumberFormatter.currency)
                        .fontWeight(.bold)
                }
                
                BudgetListView(budgetCategoryResults: budgetCategoryResults,
                               onDeleteBudgetCategory: deleteBudgetCategory, editBudgetCategory)
            }
            .sheet(item: $sheetAction, content: { sheetAction in
                //display the sheet
                switch sheetAction {
                    case .add:
                        AddBudgetCategoryView()
                    case .edit(let budgetCategory):
                    AddBudgetCategoryView(budgetCategoryToEdit: budgetCategory)
                }
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Category") {
                        isPresented = true
                    }
                }
            }.padding()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
    }
}
