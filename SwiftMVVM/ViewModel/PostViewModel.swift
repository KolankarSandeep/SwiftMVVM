//
//  PostViewModel.swift
//  SwiftMVVM
//
//  Created by Sandeep Kolankar on 13/01/22.
//

import UIKit

class PostViewModel: NSObject {
    private var dataService: DataServiceProtocol
    
    lazy var dataRepository = {
        DataRepository()
    }()

    var reloadTableView: (() -> Void)?
        
    var postCellViewModels = [PostCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    var favoritePostCellViewModels = [PostCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    // MARK: - Injection
    init(dataService: DataServiceProtocol = DataService()) {
        self.dataService = dataService
    }
        
    fileprivate func prepareFavoriteCellViewModels(posts: [Post]) {
        var vms = [PostCellViewModel]()
        for post in posts {
            vms.append(createCellModel(post: post))
        }
        favoritePostCellViewModels = vms
    }
    
    fileprivate func prepareCellViewModels() {
        let posts = self.dataRepository.fetchAllSavedPosts()
        var vms = [PostCellViewModel]()
        for post in posts {
            vms.append(createCellModel(post: post))
        }
        postCellViewModels = vms
    }
    
    fileprivate func createCellModel(post: Post) -> PostCellViewModel {
        let id = "#\(post.id)"
        let userID = "User \(post.userId)"
        let title = "$ \(post.title ?? "")"
        let body = post.body ?? ""
        let isFavorite = post.isFavorite

        return PostCellViewModel(userId: userID, id: id, title: title, body: body, isFavorite: isFavorite)
    }
    
    func getPosts() {
        dataService.getPosts { (result) in
            switch result {
            case .Success(let data):
                self.dataRepository.clearData()
                self.dataRepository.saveInCoreDataWith(array: data)
                self.prepareCellViewModels()
                break
            case .Error(_):
                self.prepareCellViewModels()
                break
            }
        }
    }
    
    func getAllFavoritePosts() {
        let favoritePosts = self.dataRepository.fetchAllFavoritePosts()
        self.prepareFavoriteCellViewModels(posts: favoritePosts)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> PostCellViewModel {
        return postCellViewModels[indexPath.row]
    }
    
    func getFavoriteCellViewModel(at indexPath: IndexPath) -> PostCellViewModel {
        return favoritePostCellViewModels[indexPath.row]
    }

    func savePostToFavorite(_ postVM: PostCellViewModel) {
        if let id = Int.parse(from: postVM.id) {
            self.dataRepository.savePostAsFavorite(postID: id, isFavoritePost: !postVM.isFavorite)
            if let index = postCellViewModels.firstIndex(where: { Int.parse(from: $0.id) == id} ) {
                postCellViewModels[index].isFavorite = !postVM.isFavorite
            }
        }
    }
}

