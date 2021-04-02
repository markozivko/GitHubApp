//
//  FavoritesViewController.swift
//  GitHubApp
//
//  Created by Zivko, Marko on 13/03/2021.
//

import UIKit

class FavoritesViewController: UIViewController {

    let tableView = UITableView()
    var favorites: [Follower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureViewController()
        self.configureTableView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getFavorites()
    }
    
    func configureViewController() {
        self.view.backgroundColor = .systemBackground
        self.title = "Favorites"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        self.view.addSubview(self.tableView)
        self.tableView.frame = self.view.bounds
        self.tableView.rowHeight = 80
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseId)
    }
    
    func getFavorites() {
        PersistanceManager.retrieveFavorites {[weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                
                if favorites.isEmpty {
                    self.showEmptyStateView(with: "No favorites yet... \n you should add one", in: self.view)
                } else {
                    print("########\(favorites)")
                    self.favorites = favorites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseId) as! FavoriteCell
        let favoite = self.favorites[indexPath.row]
        cell.set(favoite: favoite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = self.favorites[indexPath.row]
        let destinationVC = FollowersListViewController()
        destinationVC.username = favorite.login
        destinationVC.title = favorite.login
        
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let favorite = self.favorites[indexPath.row]
        
        self.favorites.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .left)
        
        PersistanceManager.updateWith(favorite: favorite, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else { return }
            
            self.presentGFAlertOnMainThread(title: "Unable to delete this user", message: error.rawValue, buttonTitle: "Ups")
        }
    }
}
