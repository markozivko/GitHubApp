//
//  UserInfoViewController.swift
//  GitHubApp
//
//  Created by Zivko, Marko on 29/03/2021.
//

import UIKit

class UserInfoViewController: UIViewController {

    let headerView = UIView()
    var username: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemBackground
        self.configure()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        self.navigationItem.rightBarButtonItem = doneButton
        
        self.title = self.username
        
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
    
    func configure() {
        self.view.addSubview(self.headerView)
        
        self.headerView.layer.cornerRadius = 10
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 180)
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
