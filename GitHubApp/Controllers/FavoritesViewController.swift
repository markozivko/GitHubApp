//
//  FavoritesViewController.swift
//  GitHubApp
//
//  Created by Zivko, Marko on 13/03/2021.
//

import UIKit

class FavoritesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemGreen
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        PersistanceManager.retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                print("########\(favorites)")
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
}
