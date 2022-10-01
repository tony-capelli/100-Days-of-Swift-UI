//
//  Attivita.swift
//  HabitTrack
//
//  Created by Tony Capelli on 29/09/22.
//

import Foundation

struct Attivita: Codable, Identifiable, Equatable {
    var id = UUID()
    let titolo: String
    let descrizione: String
    let numeroCompletato: Int
}
