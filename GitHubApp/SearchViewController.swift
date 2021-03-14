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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
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
        
    }
}
