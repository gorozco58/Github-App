//
//  Contributor.swift
//  Github App
//
//  Created by Giovanny Orozco Loaiza on 27/01/22.
//

import Foundation

struct Contributor {
    let id: Int
    let login: String
    let avatarURL: URL
    let contributions: Int
}

//MARK: - Codable
extension Contributor: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarURL = "avatar_url"
        case contributions
    }
}
