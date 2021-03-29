//
//  UserInfoViewController.swift
//  GitHubApp
//
//  Created by Zivko, Marko on 29/03/2021.
//

import UIKit

class UserInfoViewController: UIViewController {

    
    var username: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemPink
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        self.navigationItem.rightBarButtonItem = doneButton
        
        self.title = self.username
    }
    
    @objc func donePressed() {
        self.dismiss(animated: true, completion: nil)
    }
}
