//
//  FinalBudgetAppRCPApp.swift
//  FinalBudgetAppRCP
//
//  Created by Rodney Platt on 1/6/23.
//

import SwiftUI

@main
struct FinalBudgetAppRCPApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
        }
    }
}
