//
//  FollowersListViewController.swift
//  GitHubApp
//
//  Created by Zivko, Marko on 15/03/2021.
//

import UIKit

class FollowersListViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    var username: String!
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    var followers: [Follower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureViewController()
        self.configureCollectionView()
        
        self.getFollowers()
        self.configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func getFollowers() {
        NetworkManager.shared.getFollowers(for: username, page: 1) {[weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let followers):
                print("Number of followers: \(followers.count)")
                print(followers)
                
                self.followers = followers
                self.updateData()
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureViewController() {
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView() {
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: UIHelper.createThreeColumnsFlowLayout(in: self.view))
        
        self.view.addSubview(self.collectionView)
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
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
        }
    }
}
