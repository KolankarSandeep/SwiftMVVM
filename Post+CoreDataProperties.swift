//
//  Post+CoreDataProperties.swift
//  SwiftMVVM
//
//  Created by Sandeep Kolankar on 14/01/22.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var userId: Int32
    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var isFavorite: Bool
    
    func parseWith(response:[String:Any]) {
        self.userId = response["userId"] as? Int32 ?? 0
        self.id = response["id"] as? Int32 ?? 0
        self.title = response["title"] as? String
        self.body = response["body"] as? String
        self.isFavorite = response["isFavorite"] as? Bool ?? false
    }
}
