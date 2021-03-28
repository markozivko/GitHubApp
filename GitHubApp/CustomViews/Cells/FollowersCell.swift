//
//  FollowersCell.swift
//  GitHubApp
//
//  Created by Zivko, Marko on 27/03/2021.
//

import UIKit

class FollowersCell: UICollectionViewCell {
    
    static let reuseId = "FollowerCell"
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let userNameLabel = GFTitleLabel(textAlignment: .center, fontSize: 12)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
        self.userNameLabel.text = follower.login
        self.avatarImageView.downloadImage(from: follower.avatarUrl)
    }
    
    private func configure() {
        self.addSubview(self.avatarImageView)
        self.addSubview(self.userNameLabel)
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            self.avatarImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: padding),
            self.avatarImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: padding),
            self.avatarImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -padding),
            self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor),
            
            self.userNameLabel.topAnchor.constraint(equalTo: self.avatarImageView.bottomAnchor, constant: 12),
            self.userNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: padding),
            self.userNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -padding),
            self.userNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
