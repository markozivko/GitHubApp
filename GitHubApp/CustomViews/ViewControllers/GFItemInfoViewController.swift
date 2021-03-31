//
//  GFItemInfoViewController.swift
//  GitHubApp
//
//  Created by Zivko, Marko on 30/03/2021.
//

import UIKit

class GFItemInfoViewController: UIViewController {

    let stackView = UIStackView()
    let itemInfoViewOne = GFItemInfoView()
    let itemInfoViewTwo = GFItemInfoView()
    let actionButton = GFButton()
    
    var user: User?
    var delegate: UserInfoViewController!

    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        
        self.view.layer.cornerRadius = 18
        self.view.backgroundColor = .secondarySystemBackground
        
        let padding: CGFloat = 20
        
        self.view.addSubview(self.stackView)
        self.view.addSubview(self.actionButton)
        self.stackView.axis = .horizontal
        self.stackView.distribution = .equalSpacing
        self.stackView.addArrangedSubview(self.itemInfoViewOne)
        self.stackView.addArrangedSubview(self.itemInfoViewTwo)
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.actionButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: padding),
            self.stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding),
            self.stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding),
            self.stackView.heightAnchor.constraint(equalToConstant: 50),
            
            self.actionButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -padding),
            self.actionButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding),
            self.actionButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding),
            self.actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    //this method is empty because it will be overriden by the Repo/Follower item vc
    @objc func buttonPressed() {
        
    }
}
