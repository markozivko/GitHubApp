//
//  GFSecondaryTitleLabel.swift
//  GitHubApp
//
//  Created by Zivko, Marko on 30/03/2021.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        
        self.configure()
    }
    
    private func configure() {
        self.textColor = .secondaryLabel
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.9
        self.lineBreakMode = .byTruncatingTail
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
