//
//  Date+Extension.swift
//  GitHubApp
//
//  Created by Zivko, Marko on 30/03/2021.
//

import Foundation

extension Date {
    func convertToMonthAndYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        return dateFormatter.string(from: self)
    }
}
