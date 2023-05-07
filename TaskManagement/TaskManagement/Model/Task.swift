//
//  Task.swift
//  TaskManagement
//
//  Created by Tony Capelli on 07/05/23.
//

import SwiftUI

// Task Model

struct Task: Identifiable {
    var id = UUID().uuidString
    var taskTitle: String
    var taskDescription: String
    var taskDate: Date
}
