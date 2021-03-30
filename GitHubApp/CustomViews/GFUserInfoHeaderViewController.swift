//
//  GFUserInfoHeaderViewController.swift
//  GitHubApp
//
//  Created by Zivko, Marko on 30/03/2021.
//

import UIKit

class GFUserInfoHeaderViewController: UIViewController {

    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel = GFSecondaryTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let locationLabel = GFSecondaryTitleLabel(fontSize: 18)
    let bioLabel = GFBodyLabel(textAlignment: .left)
    
    var user: User?
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addSubviews()
        self.layoutUI()
        self.configure()
    }
    
    func configure() {
        guard let user = user else { return }
        
        self.avatarImageView.downloadImage(from: user.avatarUrl)
        self.usernameLabel.text = user.login
        self.nameLabel.text = user.name ?? "Username empty"
        self.locationLabel.text = user.location ?? "Location empty"
        self.bioLabel.text = user.bio
        self.bioLabel.numberOfLines = 3
        self.locationImageView.image = UIImage(systemName: SFSymbols.location)
        self.locationImageView.tintColor = .secondaryLabel
    }
    
    func addSubviews() {
        self.view.addSubview(self.avatarImageView)
        self.view.addSubview(self.usernameLabel)
        self.view.addSubview(self.nameLabel)
        self.view.addSubview(self.locationImageView)
        self.view.addSubview(self.locationLabel)
        self.view.addSubview(self.bioLabel)
    }
    
    func layoutUI() {
        
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        
        self.locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.avatarImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: padding),
            self.avatarImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding),
            self.avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            self.avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            self.usernameLabel.topAnchor.constraint(equalTo: self.avatarImageView.topAnchor),
            self.usernameLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: textImagePadding),
            self.usernameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding),
            self.usernameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            self.nameLabel.centerYAnchor.constraint(equalTo: self.avatarImageView.centerYAnchor, constant: 8),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: textImagePadding),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding),
            self.nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            self.locationImageView.bottomAnchor.constraint(equalTo: self.avatarImageView.bottomAnchor),
            self.locationImageView.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: textImagePadding),
            self.locationImageView.widthAnchor.constraint(equalToConstant: 20),
            self.locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            self.locationLabel.centerYAnchor.constraint(equalTo: self.locationImageView.centerYAnchor),
            self.locationLabel.leadingAnchor.constraint(equalTo: self.locationImageView.trailingAnchor, constant: 5),
            self.locationLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding),
            self.locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            self.bioLabel.topAnchor.constraint(equalTo: self.avatarImageView.bottomAnchor, constant: textImagePadding),
            self.bioLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.leadingAnchor),
            self.bioLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding),
            self.bioLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
