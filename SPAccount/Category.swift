//
//  Category.swift
//  SPAccount
//
//  Created by Sebastien on 02/11/2018.
//  Copyright © 2018 Sebastien. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name = ""
    @objc dynamic var cap = 0
    let operations = List<Operation>()
    
    
    func getCurrentMonthOperation() -> [Operation] {
        let currentDate = Date()
        return self.operations.filter {$0.creationDate.monthNumber() == currentDate.monthNumber()}
    }
    
    /// Si forMonth = false on fait YTD
    func makePercent(forMonth: Bool) -> Int {
        let expenses = forMonth ? self.totalMonthExpenses() : self.totalExpenses()
        return Int(CGFloat(expenses) / CGFloat(self.cap * (forMonth ? 1 : 2)) * 100)
    }
    
    func totalExpenses() -> Int {
        return self.computeExpenses(operations: self.operations.compactMap {$0})
    }
    
    func totalMonthExpenses() -> Int {
        return self.computeExpenses(operations: self.getCurrentMonthOperation())
    }
    
    //MARK: Méthode privée
    
    private func computeExpenses(operations: [Operation]) -> Int {
        return operations.map {$0.amount}.reduce(0, +)
    }
}

