//
//  GFRepoItemViewController.swift
//  GitHubApp
//
//  Created by Zivko, Marko on 30/03/2021.
//

import Foundation
import UIKit

class GFRepoItemViewController: GFItemInfoViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureItems()
    }
    
    private func configureItems() {
        guard let user = self.user else { return }
        self.itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        self.itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        
        self.actionButton.backgroundColor = .systemPurple
        self.actionButton.setTitle("GitHub Profile", for: .normal)
    }
    
    override func buttonPressed() {
        guard let user = self.user else { return }
        self.delegate.didTapGitHubProfile(for: user)
    }
}
