//
//  HomeEntity.swift
//  TopSwift
//
//  Created by Felipe Imamura on 31/05/20.
//  Copyright © 2020 Felipe Imamura. All rights reserved.
//

import Foundation


struct Repository: Codable {
    
    var id: Int
    var name: String
    var stargazers_count: Int
    var owner: Owner
}

struct Owner: Codable {
    
    var id: Int
    var avatar_url: String
    var url: String
    var login: String
//    var github_id: Int
}

struct RepositoryResponseData: Codable {

    var items: [Repository]
}


struct OwnerUser: Codable {
    
    var id: Int
    var name: String?
    var login: String
//    var github_id: Int
}

struct OwnerUserResponseData: Codable {

    var user: OwnerUser
}
