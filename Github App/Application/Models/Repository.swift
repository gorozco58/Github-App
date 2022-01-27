//
//  Repository.swift
//  Github App
//
//  Created by Giovanny Orozco Loaiza on 27/01/22.
//

import Foundation

struct RepositoriesResponse {
    let total: Int
    let items: [Repository]
}

struct Repository {
    let id: Int
    let name: String
    let description: String
    let owner: Owner
}

//MARK: - Codable
extension Repository: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case owner
    }
}

extension RepositoriesResponse: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case total = "total_count"
        case items
    }
}
