//
//  DataService.swift
//  SwiftMVVM
//
//  Created by Sandeep Kolankar on 13/01/22.
//

import Foundation
import Alamofire

enum Result<T> {
    case Success(T)
    case Error(String)
}

protocol DataServiceProtocol {
    func getPosts(completion: @escaping (_ results: Result<[[String: AnyObject]]>) -> ())
}

class DataService: DataServiceProtocol {
        
    func getPosts(completion: @escaping (Result<[[String: AnyObject]]>) -> ()) {
        
        Alamofire.request(Constants.URLs.postsUrl).responseJSON { response in
            if let error = response.error {
                completion(.Error(error.localizedDescription))
                return
            }
            if let postsData = response.data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: postsData, options: [.mutableContainers]) as? [[String: AnyObject]] {
                        completion(.Success(json))
                    }
                } catch let error as NSError{
                    completion(.Error(error.localizedDescription))
                }
            }
        }
    }
}
