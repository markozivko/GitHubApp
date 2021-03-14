//
//  GFTextField.swift
//  GitHubApp
//
//  Created by Zivko, Marko on 14/03/2021.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.systemGray4.cgColor
        
        self.textColor = .label
        //color of the blinking cursor
        // .label color makes it white or black depending on the dark/light mode
        self.tintColor = .label
        self.textAlignment = .center
        self.font = UIFont.preferredFont(forTextStyle: .title2)
        self.minimumFontSize = 12
        self.backgroundColor = .tertiarySystemBackground
        self.autocorrectionType = .no
        self.placeholder = "Enter a username"
        
        self.translatesAutoresizingMaskIntoConstraints = false

    }
}
