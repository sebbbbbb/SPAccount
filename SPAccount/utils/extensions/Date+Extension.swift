//
//  Date+Extension.swift
//  SPAccount
//
//  Created by Sebastien on 03/11/2018.
//  Copyright © 2018 Sebastien. All rights reserved.
//

import Foundation

extension Date {
    
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        return dateFormatter.string(from: self)
    }

    func monthNumber() -> Int {
        let calendar = Calendar.current
        return calendar.component(.month, from: self)
    }
    
}
