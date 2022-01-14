//
//  UserPost+CoreDataProperties.swift
//  SwiftMVVM
//
//  Created by Sandeep Kolankar on 14/01/22.
//
//

import Foundation
import CoreData


extension UserPost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserPost> {
        return NSFetchRequest<UserPost>(entityName: "UserPost")
    }

    @NSManaged public var id: Int32
    @NSManaged public var userId: Int32
    @NSManaged public var isFavorite: Bool
    @NSManaged public var title: String?
    @NSManaged public var body: String?

}

extension UserPost : Identifiable {

}
