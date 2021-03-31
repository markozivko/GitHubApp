//
//  FollowersListViewController.swift
//  GitHubApp
//
//  Created by Zivko, Marko on 15/03/2021.
//

import UIKit

protocol FollowerListViewControllerDelegate {
    func didRequestFollowers(for username: String)
}

class FollowersListViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    var page = 1
    var username: String!
    var hasMoreFollowers = true
    var isSearching = false
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureViewController()
        self.configureCollectionView()
        self.configureSearchController()
        
        self.getFollowers(username: self.username, page: self.page)
        self.configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func getFollowers(username: String, page: Int) {
        self.showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) {[weak self] result in
            
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                print("Number of followers: \(followers.count)")
                print(followers)
                
                if followers.count < 100 {
                    self.hasMoreFollowers = false
                }
                
                //MARK: we need to append because we need to add new array of followers in order to see 100 first and 100 that follow
                self.followers.append(contentsOf: followers)
                
                //MARK: here we are sure that we appened all we need, and now we can really check whether user does or doesn't have any followers
                if self.followers.isEmpty {
                    let message = "This user does not have any followers. Go follow them! 😄"
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: message, in: self.view)
                    }
                    return
                }
                self.updateData(on: self.followers)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureViewController() {
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let addFavoritesButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToFavoritesPressed))
        self.navigationItem.rightBarButtonItem = addFavoritesButton
    }
    
    func configureCollectionView() {
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: UIHelper.createThreeColumnsFlowLayout(in: self.view))
        
        self.view.addSubview(self.collectionView)
        self.collectionView.delegate = self
        self.collectionView.backgroundColor = .systemBackground
        self.collectionView.register(FollowersCell.self, forCellWithReuseIdentifier: FollowersCell.reuseId)
    }
    
    func configureDataSource() {
        self.dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: self.collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowersCell.reuseId, for: indexPath) as! FollowersCell
            
            cell.set(follower: follower)
            
            return cell
        })
    }
    
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
        }
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        self.navigationItem.searchController = searchController
    }
    
    @objc func addToFavoritesPressed() {
        self.showLoadingView()
        NetworkManager.shared.getUserInfo(for: self.username) { [weak self] result in
            guard let self = self else { return }
            
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                PersistanceManager.updateWith(favorite: favorite, actionType: .add) {[weak self] error in
                    guard let self = self else { return }
                    guard (error != nil) else {
                        self.presentGFAlertOnMainThread(title: "Success!", message: "You have added this person to the favorites list! 🎉", buttonTitle: "Amazing")
                        return
                    }
                    
                    self.presentGFAlertOnMainThread(title: "Something went wrong", message: error!.rawValue, buttonTitle: "Ok")
                }
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}

extension FollowersListViewController: UICollectionViewDelegate, UISearchResultsUpdating, UISearchBarDelegate, FollowerListViewControllerDelegate {
    
    func didRequestFollowers(for username: String) {
        //get followers for that user
        
        //reset the screen
        self.username = username
        self.title = username
        self.page = 1
        self.followers.removeAll()
        self.filteredFollowers.removeAll()
        self.collectionView.setContentOffset(.zero, animated: true)
        
        self.getFollowers(username: username, page: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = self.isSearching ? self.filteredFollowers : self.followers
        let follower = activeArray[indexPath.item]
        
        let destionationVc = UserInfoViewController()
        destionationVc.username = follower.login
        destionationVc.delegate = self
        let navigationController = UINavigationController(rootViewController: destionationVc)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            self.page += 1
            getFollowers(username: self.username, page: self.page)
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        
        self.isSearching = true
        self.filteredFollowers = self.followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        self.updateData(on: self.filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.isSearching = false
        self.updateData(on: self.followers)
    }
}
