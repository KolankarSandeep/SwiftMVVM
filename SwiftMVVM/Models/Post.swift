//
//  Post.swift
//  SwiftMVVM
//
//  Created by Sandeep Kolankar on 11/01/22.
//

import Foundation

typealias Posts = [Post]

struct Post: Decodable {
    var userID: Int
    var id: Int
    var title: String
    var body: String
    var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
    
}

extension Post {
    func encode() -> Data {
        let archiver = NSKeyedArchiver.init(requiringSecureCoding: true)
        archiver.encode(userID, forKey: "userId")
        archiver.encode(id, forKey: "id")
        archiver.encode(title, forKey: "title")
        archiver.encode(body, forKey: "body")
        archiver.encode(isFavorite, forKey: "isFavorite")
        archiver.finishEncoding()
        return archiver.encodedData as Data
    }

    init?(data: Data) {
        do {
            let unarchiver = try NSKeyedUnarchiver.init(forReadingFrom: data)
            defer {
                unarchiver.finishDecoding()
            }
            guard let userId = unarchiver.decodeInteger(forKey: "userId") as? Int else { return nil }
            guard let id = unarchiver.decodeInteger(forKey: "id") as? Int else { return nil }
            guard let title = unarchiver.decodeObject(forKey: "title") as? String else { return nil }
            guard let body = unarchiver.decodeObject(forKey: "body") as? String else { return nil }
            guard let isFavorite = unarchiver.decodeBool(forKey: "isFavorite") as? Bool else { return nil }
            self.userID = userId
            self.id = id
            self.isFavorite = isFavorite
            self.title = title
            self.body = body
        } catch {
            self.userID = 0
            self.id = 0
            self.isFavorite = false
            self.title = "title"
            self.body = "body"
            print("error")
        }
    }
}
