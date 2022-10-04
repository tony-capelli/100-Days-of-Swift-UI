//
//  UserFriendApp.swift
//  UserFriend
//
//  Created by Tony Capelli on 03/10/22.
//

import SwiftUI

@main
struct UserFriendApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
