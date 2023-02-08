//
//  TranactionCoreDateClass.swift
//  FinalBudgetAppRCP
//
//  Created by Rodney Platt on 1/13/23.
//

import Foundation
import CoreData


@objc(Transaction)
public class Transaction: NSManagedObject {
    
    public override func awakeFromInsert() {
        self.dateCreated = Date()
    }
}
