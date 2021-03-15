//
//  GFAlertController.swift
//  GitHubApp
//
//  Created by Zivko, Marko on 15/03/2021.
//

import UIKit

class GFAlertController: UIViewController {

    let alertContainer = UIView()
    let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = GFBodyLabel(textAlignment: .center)
    let actionButton = GFButton(backgroundColor: .systemPink, title: "I Understand")
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        self.configureAlertContailer()
        self.configureTitleLabel()
        self.configureActionButton()
        self.configureBodyLabel()
    }
    
    func configureAlertContailer() {
        self.view.addSubview(self.alertContainer)
        
        self.alertContainer.layer.cornerRadius = 16
        self.alertContainer.layer.borderWidth = 2
        self.alertContainer.layer.borderColor = UIColor.white.cgColor
        self.alertContainer.backgroundColor = .systemBackground
        
        self.alertContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.alertContainer.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.alertContainer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.alertContainer.widthAnchor.constraint(equalToConstant: 280),
            self.alertContainer.heightAnchor.constraint(equalToConstant: 240)
        ])
    }
    
    func configureTitleLabel() {
        self.alertContainer.addSubview(self.titleLabel)
        
        self.titleLabel.text = alertTitle ?? "Something went wrong..."
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.alertContainer.topAnchor, constant: padding),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.alertContainer.leadingAnchor, constant: padding),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.alertContainer.trailingAnchor, constant: -padding),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configureActionButton() {
        self.alertContainer.addSubview(self.actionButton)
        self.actionButton.setTitle(self.buttonTitle, for: .normal)
        self.actionButton.addTarget(self, action: #selector(self.dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            self.actionButton.bottomAnchor.constraint(equalTo: self.alertContainer.bottomAnchor, constant: -padding),
            self.actionButton.leadingAnchor.constraint(equalTo: self.alertContainer.leadingAnchor, constant: padding),
            self.actionButton.trailingAnchor.constraint(equalTo: self.alertContainer.trailingAnchor, constant: -padding),
            self.actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func configureBodyLabel() {
        self.alertContainer.addSubview(self.messageLabel)
        
        self.messageLabel.text = self.message
        self.messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            self.messageLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8),
            self.messageLabel.leadingAnchor.constraint(equalTo: self.alertContainer.leadingAnchor, constant: padding),
            self.messageLabel.trailingAnchor.constraint(equalTo: self.alertContainer.trailingAnchor, constant: -padding),
            self.messageLabel.bottomAnchor.constraint(equalTo: self.actionButton.topAnchor, constant: -12)
        ])
    }
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
}
