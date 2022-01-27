//
//  Owner.swift
//  Github App
//
//  Created by Giovanny Orozco Loaiza on 27/01/22.
//

import Foundation

struct Owner {
    let id: Int
    let login: String
    let avatarURL: URL
}

//MARK: - Codable
extension Owner: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarURL = "avatar_url"
    }
}

