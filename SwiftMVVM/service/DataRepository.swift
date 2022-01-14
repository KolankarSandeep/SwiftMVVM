//
//  DataRepository.swift
//  SwiftMVVM
//
//  Created by Sandeep Kolankar on 13/01/22.
//

import UIKit
import CoreData

class DataRepository {
            
    init() {
    }
        
    func savePostAsFavorite(postID: Int, isFavoritePost: Bool) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Post")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format:"id == %d", Int32(postID))

        let result = try? CoreDataStack.persistentContainer.viewContext.fetch(fetchRequest) as? [Post]

        if result?.count == 1, let post = result?[0] {
            post.isFavorite = isFavoritePost
            CoreDataStack.persistentContainer.viewContext.performAndWait {
                do {
                    try CoreDataStack.persistentContainer.viewContext.save()
                } catch let error as NSError {
                    print("could not save, managedobject \(error), \(error.userInfo)")
                }
            }
        }
    }
                
    // MARK: - Private
    public func fetchAllFavoritePosts() -> [Post] {
        let request: NSFetchRequest<Post> = Post.fetchRequest()
        let sectionSortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        let sortDescriptors = [sectionSortDescriptor]
        request.sortDescriptors = sortDescriptors
        let predicate = NSPredicate(format: "isFavorite = \(NSNumber(value:true))")
        request.predicate = predicate
        do {
            let results = try CoreDataStack.persistentContainer.viewContext.fetch(request)
            return results
        } catch let error as NSError {
            print(error)
            return [Post]()
        }
    }
        
    public func fetchAllSavedPosts() -> [Post] {
        let request: NSFetchRequest<Post> = Post.fetchRequest()
        request.returnsObjectsAsFaults = false
        let sectionSortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        let sortDescriptors = [sectionSortDescriptor]
        request.sortDescriptors = sortDescriptors
        do {
            let result = try CoreDataStack.persistentContainer.viewContext.fetch(request)
            for data in result {
                print(data)
            }
            return result
        } catch {
            print("fetch request failed, managedobject")
            return [Post]()
        }
    }
    
    private func createPostEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
        let context = CoreDataStack.persistentContainer.viewContext
        if let post = NSEntityDescription.insertNewObject(forEntityName: "Post", into: context) as? Post {
            post.userId = dictionary["userId"] as? Int32 ?? 0
            post.id = dictionary["id"] as? Int32 ?? 0
            post.title = dictionary["title"] as? String
            post.body = dictionary["body"] as? String
            post.isFavorite = dictionary["isFavorite"] as? Bool ?? false
            return post
        }
        return nil
    }
    
    func saveInCoreDataWith(array: [[String: AnyObject]]) {
        _ = array.map{self.createPostEntityFrom(dictionary: $0)}
        do {
            try CoreDataStack.persistentContainer.viewContext.save()
        } catch let error {
            print(error)
        }
    }
    
    func clearData() {
        do {
            let context = CoreDataStack.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Post.self))
            do {
                let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
                _ = objects.map{$0.map{context.delete($0)}}
                CoreDataStack.saveContext()
            } catch let error {
                print("ERROR DELETING : \(error)")
            }
        }
    }
}
