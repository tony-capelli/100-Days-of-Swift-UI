//
//  CachedUser+CoreDataProperties.swift
//  UserFriend
//
//  Created by Tony Capelli on 04/10/22.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var isActive: Bool
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var company: String?
    @NSManaged public var registered: Date?
    @NSManaged public var about: String?
    @NSManaged public var age: Int16
    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var friends: NSSet?
    
    var wrappedName: String {
        name ?? "Unknown name"
    }
    
    var wrappedCompany: String {
        company ?? "Unknown company"
    }
    
    var wrappedAbout: String {
        about ?? "Unknown description"
    }
    
    var wrappedEmail: String {
        email ?? "Unknown mail"
    }
    
    var wrappedAddress: String {
        address ?? "Unknown address"
    }
    
    var wrappedFormattedDate: Date {
        registered ?? Date()
    }
    
    var wrappedID: String {
        id ?? "abc"
    }
    
    public var friendArray: [CachedFriend] {
        let set = friends as? Set<CachedFriend> ?? []
        
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }

}

// MARK: Generated accessors for friends
extension CachedUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CachedFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CachedFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
