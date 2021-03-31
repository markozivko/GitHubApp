//
//  GFFollowerItemViewController.swift
//  GitHubApp
//
//  Created by Zivko, Marko on 30/03/2021.
//

import Foundation
import UIKit

class GFFolloweItemViewController: GFItemInfoViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureItems()
    }
    
    private func configureItems() {
        guard let user = self.user else { return }
        self.itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        self.itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        
        self.actionButton.backgroundColor = .systemGreen
        self.actionButton.setTitle("Get Followers", for: .normal)
    }
    
    override func buttonPressed() {
        guard let user = self.user else { return }
        self.delegate.didTapGetFollowers(for: user)
    }
}

