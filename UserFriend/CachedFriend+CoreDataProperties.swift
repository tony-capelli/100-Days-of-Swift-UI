//
//  CachedFriend+CoreDataProperties.swift
//  UserFriend
//
//  Created by Tony Capelli on 04/10/22.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var user: CachedUser?

    var wrappedName: String {
        name ?? "Unknown name"
    }
}

extension CachedFriend : Identifiable {

}
