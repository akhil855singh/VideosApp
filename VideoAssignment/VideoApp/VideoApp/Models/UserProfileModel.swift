//
//  UserProfileModel.swift
//  VideoApp
//
//  Created by Akhil Singh on 29/01/20.
//  Copyright © 2020 Akhil Singh. All rights reserved.
//

import Foundation

struct PostsModel: Decodable {
    let id:String?
    let imageUrl:String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case imageUrl = "userImageUrl"
    }
}

struct UserProfileModel{
    let imageUrl:String?
    let name:String?
    let title:String?
    let description:String?
    let posts:[PostsModel]?
}

extension UserProfileModel: Decodable {
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: Keys.self)
        let name = try container.decode(String.self, forKey: .name)
        let title = try container.decode(String.self, forKey: .title)
        let description = try container.decode(String.self, forKey: .description)
        let imageUrl = try container.decode(String.self, forKey: .imageUrl)
        let posts = try container.decode([PostsModel].self, forKey: .posts)
            
        self.init(imageUrl: imageUrl, name: name, title: title, description: description, posts: posts)
    }
    
    private enum Keys: String, CodingKey {
        case name = "userName"
        case description
        case title
        case imageUrl = "userImageUrl"
        case posts
    }
}
