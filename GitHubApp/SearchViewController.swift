//
//  SearchViewController.swift
//  GitHubApp
//
//  Created by Zivko, Marko on 13/03/2021.
//

import UIKit

class SearchViewController: UIViewController {

    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        self.configureLogoImageView()
        self.configureTextField()
        self.configureCallToActionButton()
        self.createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowersListViewController() {
        let followerList = FollowersListViewController()
        followerList.username = self.usernameTextField.text
        followerList.title = self.usernameTextField.text
        self.navigationController?.pushViewController(followerList, animated: true)
    }
        
    func configureLogoImageView() {
        self.view.addSubview(self.logoImageView)

        self.logoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.logoImageView.image = UIImage(named: "gh-logo")!
        
        NSLayoutConstraint.activate([
            self.logoImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 80),
            self.logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.logoImageView.heightAnchor.constraint(equalToConstant: 200),
            self.logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField() {
        
        self.usernameTextField.delegate = self
        
        self.view.addSubview(self.usernameTextField)
        
        NSLayoutConstraint.activate([
            self.usernameTextField.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 48),
            self.usernameTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            self.usernameTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
            self.usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureCallToActionButton() {
        
        self.view.addSubview(self.callToActionButton)
        
        NSLayoutConstraint.activate([
            self.callToActionButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            self.callToActionButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            self.callToActionButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
            self.callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        self.callToActionButton.addTarget(self, action: #selector(self.pushFollowersListViewController), for: .touchUpInside)
        
    }
}

extension SearchViewController: UITextFieldDelegate {
    
    //called when user press Go or any other Return button within the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Did tap return")
        self.pushFollowersListViewController()
        return true
    }
    
}
