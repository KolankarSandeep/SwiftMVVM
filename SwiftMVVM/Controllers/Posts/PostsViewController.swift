//
//  PostsViewController.swift
//  SwiftMVVM
//
//  Created by Sandeep Kolankar on 13/01/22.
//

import UIKit

class PostsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let activityIndicatorView = UIActivityIndicatorView(style: .large)
    
    // MARK: - Injection
    lazy var viewModel = {
        PostViewModel(dataService: DataService())
    }()
    
    func initViewModel() {
        viewModel.getPosts()
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicatorView.stopAnimating()
                self?.activityIndicatorView.isHidden = true
                self?.tableView.isHidden = false
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.center = view.center
        activityIndicatorView.startAnimating()
        view.addSubview(activityIndicatorView)
        tableView.isHidden = true
        activityIndicatorView.isHidden = false
        initViewModel()
    }
    
}

extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.postCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.postCellIdentifier) as? PostCell else { return PostCell() }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView.cellForRow(at: indexPath) as! PostCell
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.favoriteImageview.isHighlighted = !cellVM.isFavorite
        viewModel.savePostToFavorite(cellVM)
    }
}
