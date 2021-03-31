//
//  UIViewController+Extension.swift
//  GitHubApp
//
//  Created by Zivko, Marko on 15/03/2021.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView!

extension UIViewController {
    
    func presentSafariViewController(with url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.preferredControlTintColor = .systemGreen
        self.present(safariViewController, animated: true, completion: nil)
    }
    
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertController(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        self.view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0

        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }
        
        let activityIndication = UIActivityIndicatorView(style: .large)
        containerView.addSubview((activityIndication))
        activityIndication.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndication.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndication.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        activityIndication.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = self.view.bounds
        self.view.addSubview(emptyStateView)
    }
}
