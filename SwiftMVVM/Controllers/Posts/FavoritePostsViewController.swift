//
//  FavoritePostsViewController.swift
//  SwiftMVVM
//
//  Created by Sandeep Kolankar on 13/01/22.
//

import UIKit

class FavoritePostsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
        
    // MARK: - Injection
    lazy var viewModel = {
        PostViewModel()
    }()
    
    func initViewModel() {
        viewModel.getAllFavoritePosts()
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelection = true
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initViewModel()
    }
}

extension FavoritePostsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favoritePostCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.postCellIdentifier) as? PostCell else { return PostCell() }
        let cellVM = viewModel.getFavoriteCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
    
}

