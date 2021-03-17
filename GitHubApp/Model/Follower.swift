//
//  Follower.swift
//  GitHubApp
//
//  Created by Zivko, Marko on 17/03/2021.
//

import Foundation

struct Follower: Codable {
    
    //MARK: Codable protocol requires to use the same names retreived from JSON response
    
    var login: String
    var avatarUrl: String
}
