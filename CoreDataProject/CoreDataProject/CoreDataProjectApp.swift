//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Tony Capelli on 02/10/22.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    let dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
