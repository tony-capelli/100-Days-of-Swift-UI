//
//  OggettoSpesa.swift
//  iExpenses2
//
//  Created by Tony Capelli on 26/09/22.
//

import Foundation

struct OggettoSpesa: Identifiable, Codable {
    var id = UUID()
    let nome: String
    let tipo: String
    let costo: Double
}
