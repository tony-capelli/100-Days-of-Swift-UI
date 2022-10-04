//
//  DataController.swift
//  UserFriend
//
//  Created by Tony Capelli on 04/10/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Model")
    
    init(){
        container.loadPersistentStores{ descriptors, error in
            if let error = error {
                print("Failed to load Core Data \(error.localizedDescription)")
            }
        }
    }
}
