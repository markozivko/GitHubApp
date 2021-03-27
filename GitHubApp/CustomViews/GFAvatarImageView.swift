//
//  GFAvatarImageView.swift
//  GitHubApp
//
//  Created by Zivko, Marko on 27/03/2021.
//

import UIKit

class GFAvatarImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.image = UIImage(named: "avatar-placeholder")
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
