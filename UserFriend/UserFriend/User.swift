//
//  UserManager.swift
//  UserFriend
//
//  Created by Tony Capelli on 03/10/22.
//

import Foundation

struct User: Decodable, Identifiable{
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
    
    struct Friend: Decodable, Identifiable {
        let id: String
        let name: String
    }
}

