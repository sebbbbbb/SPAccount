//
//  DetailViewModel.swift
//  SPAccount
//
//  Created by Sebastien on 03/11/2018.
//  Copyright © 2018 Sebastien. All rights reserved.
//

import Foundation

class DetailViewModel {
    
    let categoryViewModel: [DetailCategoryViewModel]
    
    init(categories: [Category]) {
        self.categoryViewModel = categories.map {DetailCategoryViewModel(category: $0)}
    }
    
}

class DetailCategoryViewModel {
   
    let titleForHeader: String
    let items: [DetailItemViewModel]
    
    init(category: Category) {
        let monthExpenses = category.totalMonthExpenses()
        let monthPercentExpenses = category.makePercent(forMonth: true)
        let YTDExpenses = category.totalExpenses()
        let YTDPercentExpenses = category.makePercent(forMonth: false)
        self.items = category.operations.map {DetailItemViewModel(operation: $0)}
        self.titleForHeader = "\(category.name) 💵\(monthExpenses)€ \(monthPercentExpenses)%  💵 \(YTDExpenses)€ \(YTDPercentExpenses)%"
    }
 
}


class DetailItemViewModel {
    let mainText: String
    let subText: String
    
    init(operation: Operation) {
        self.mainText = operation.name
        self.subText = "\(operation.amount)€ - \(operation.creationDate.toString())"
    }
    
}
