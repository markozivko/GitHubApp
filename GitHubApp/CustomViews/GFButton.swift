//
//  GFButton.swift
//  GitHubApp
//
//  Created by Zivko, Marko on 14/03/2021.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: custom init for our button appearance
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        self.configure()
    }
    
    private func configure() {
        self.layer.cornerRadius = 10
        self.setTitleColor(.white, for: .normal )
        self.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
