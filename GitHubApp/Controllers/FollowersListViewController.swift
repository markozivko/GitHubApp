//
//  FollowersListViewController.swift
//  GitHubApp
//
//  Created by Zivko, Marko on 15/03/2021.
//

import UIKit

class FollowersListViewController: UIViewController {
    
    var username: String!
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureViewController()
        self.configureCollectionView()
        
        self.getFollowers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func getFollowers() {
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            switch result {
            case .success(let followers):
                print("Number of followers: \(followers.count)")
                print(followers)
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
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: createThreeColumnsFlowLayout())
        
        self.view.addSubview(self.collectionView)
        self.collectionView.backgroundColor = .systemPink
        self.collectionView.register(FollowersCell.self, forCellWithReuseIdentifier: FollowersCell.reuseId)
    }
    
    func createThreeColumnsFlowLayout() -> UICollectionViewFlowLayout {
        let width = self.view.bounds.width
        let padding: CGFloat = 12
        let spacing: CGFloat = 10
        
        let availableWidth = width - (padding * 2) - (spacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
}
