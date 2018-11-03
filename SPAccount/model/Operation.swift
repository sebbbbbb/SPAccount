//
//  Operation.swift
//  SPAccount
//
//  Created by Sebastien on 29/10/2018.
//  Copyright © 2018 Sebastien. All rights reserved.
//

import Foundation
import RealmSwift

class Operation: Object {
    @objc dynamic var name = ""
    @objc dynamic var amount = 0
    @objc dynamic var creationDate = Date()    
}
