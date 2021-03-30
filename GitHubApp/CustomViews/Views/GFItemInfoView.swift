//
//  GFItemInfoView.swift
//  GitHubApp
//
//  Created by Zivko, Marko on 30/03/2021.
//

import UIKit

enum ItemInfoType {
    case repos, gists, followers, following
}

class GFItemInfoView: UIView {

    let simbolImageView = UIImageView()
    let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.addSubview(self.simbolImageView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.countLabel)
        
        self.simbolImageView.translatesAutoresizingMaskIntoConstraints = false
        self.simbolImageView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            self.simbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.simbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.simbolImageView.widthAnchor.constraint(equalToConstant: 20),
            self.simbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            self.titleLabel.centerYAnchor.constraint(equalTo: self.simbolImageView.centerYAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.simbolImageView.trailingAnchor, constant: 12),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            self.countLabel.topAnchor.constraint(equalTo: self.simbolImageView.bottomAnchor, constant: 4),
            self.countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func set(itemInfoType: ItemInfoType, withCount count: Int) {
        switch itemInfoType {
        case .repos:
            self.simbolImageView.image = UIImage(systemName: SFSymbols.folder)
            self.titleLabel.text = "Public Repos"
        case .gists:
            self.simbolImageView.image = UIImage(systemName: SFSymbols.gists)
            self.titleLabel.text = "Public Gists"
        case .followers:
            self.simbolImageView.image = UIImage(systemName: SFSymbols.followers)
            self.titleLabel.text = "Followers"
        case .following:
            self.simbolImageView.image = UIImage(systemName: SFSymbols.following)
            self.titleLabel.text = "Following"
        }
        
        self.countLabel.text = "\(count)"

    }
}
