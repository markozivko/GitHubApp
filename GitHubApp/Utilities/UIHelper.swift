//
//  UIHelper.swift
//  GitHubApp
//
//  Created by Zivko, Marko on 28/03/2021.
//

import Foundation
import UIKit

struct UIHelper {
    
    static func createThreeColumnsFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let spacing: CGFloat = 10
        
        let availableWidth = width - (padding * 2) - (spacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
}
