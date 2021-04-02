//
//  FavoriteCell.swift
//  GitHubApp
//
//  Created by Zivko, Marko on 02/04/2021.
//

import UIKit

class FavoriteCell: UITableViewCell {

    static let reuseId = "FavoriteCell"
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let userNameLabel = GFTitleLabel(textAlignment: .left, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favoite: Follower) {
        self.userNameLabel.text = favoite.login
        self.avatarImageView.downloadImage(from: favoite.avatarUrl)
    }
    
    private func configure() {
        self.addSubview(self.avatarImageView)
        self.addSubview(self.userNameLabel)
        
        self.accessoryType = .disclosureIndicator
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            self.avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            self.avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            self.avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            self.userNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.userNameLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: 24),
            self.userNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            self.userNameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
