//
//  UserInfoViewController.swift
//  GitHubApp
//
//  Created by Zivko, Marko on 29/03/2021.
//

import UIKit

class UserInfoViewController: UIViewController {

    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    
    var username: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureViewController()
        self.configure()
        self.getUserDataInfo()

    }
    
    func getUserDataInfo() {
        guard let username = self.username else { return }
        NetworkManager.shared.getUserInfo(for: username, completed: { [weak self]result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                print(user)
                DispatchQueue.main.async {
                    self.add(childVC: GFUserInfoHeaderViewController(user: user), to: self.headerView)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        })

    }
    
    func configureViewController() {
        self.view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        self.navigationItem.rightBarButtonItem = doneButton
        self.title = self.username
    }
    
    func configure() {
        self.view.addSubview(self.headerView)
        self.view.addSubview(self.itemViewOne)
        self.view.addSubview(self.itemViewTwo)
        
        let padding: CGFloat = 20
        
        self.headerView.layer.cornerRadius = 10
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        self.itemViewOne.translatesAutoresizingMaskIntoConstraints = false
        self.itemViewTwo.translatesAutoresizingMaskIntoConstraints = false
        
        self.itemViewOne.backgroundColor = .systemOrange
        self.itemViewTwo.backgroundColor = .systemBlue
        
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 180),
            
            self.itemViewOne.topAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: padding),
            self.itemViewOne.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding),
            self.itemViewOne.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding),
            self.itemViewOne.heightAnchor.constraint(equalToConstant: 140),
            
            self.itemViewTwo.topAnchor.constraint(equalTo: self.itemViewOne.bottomAnchor, constant: padding),
            self.itemViewTwo.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding),
            self.itemViewTwo.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding),
            self.itemViewTwo.heightAnchor.constraint(equalToConstant: 140),
            
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        self.addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func donePressed() {
        self.dismiss(animated: true, completion: nil)
    }
}
