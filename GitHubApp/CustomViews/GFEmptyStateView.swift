//
//  GFEmptyStateView.swift
//  GitHubApp
//
//  Created by Zivko, Marko on 28/03/2021.
//

import UIKit

class GFEmptyStateView: UIView {

    let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()
    
    init(message: String) {
        super.init(frame: .zero)
        self.messageLabel.text = message
        self.configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.addSubview(self.messageLabel)
        self.addSubview(self.logoImageView)
        
        self.messageLabel.numberOfLines = 3
        self.messageLabel.textColor = .secondaryLabel
        
        self.logoImageView.image = UIImage(named: "empty-state-logo")
        self.logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            self.messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            self.messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            self.messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
            self.logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            self.logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            self.logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            self.logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40)
        ])
    }
}
