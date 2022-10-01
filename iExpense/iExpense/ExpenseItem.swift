//
//  ExspenseItem.swift
//  iExpense
//
//  Created by Tony Capelli on 26/09/22.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
