//
//  GFBodyLabel.swift
//  GitHubApp
//
//  Created by Zivko, Marko on 15/03/2021.
//

import UIKit

class GFBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        
        self.configure()
    }
    
    private func configure() {
        self.textColor = .secondaryLabel
        self.font = UIFont.preferredFont(forTextStyle: .body)
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.75
        self.lineBreakMode = .byWordWrapping
        
        self.translatesAutoresizingMaskIntoConstraints = true
    }

}
