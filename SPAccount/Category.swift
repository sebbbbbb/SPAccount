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
    
    
}

