//
//  UserInfoViewController.swift
//  GitHubApp
//
//  Created by Zivko, Marko on 29/03/2021.
//

import UIKit

class UserInfoViewController: UIViewController {

    
    var username: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemPink
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        self.navigationItem.rightBarButtonItem = doneButton
        
        self.title = self.username
        
        guard let username = self.username else { return }
        NetworkManager.shared.getUserInfo(for: username, completed: { [weak self]result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                print(user)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        })
    }
    
    @objc func donePressed() {
        self.dismiss(animated: true, completion: nil)
    }
}
