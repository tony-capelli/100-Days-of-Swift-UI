//
//  DataController.swift
//  CoreDataProject
//
//  Created by Tony Capelli on 02/10/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "CoreDataProject")
    
    init(){
        container.loadPersistentStores { descroption, error in
            if let error = error {
                print("Failer to load Core Data: \(error.localizedDescription)")
            }
        }
    }
}
