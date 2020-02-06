//
//  VideoListingModel.swift
//  VideoApp
//
//  Created by Akhil Singh on 27/01/20.
//  Copyright © 2020 Akhil Singh. All rights reserved.
//

import Foundation

struct VideoListing:Codable {
 
    let name: String?
    let id:String?
    let videoUrl: String?
    let imageUrl: String?
    let time: String?
    
    private enum CodingKeys: String, CodingKey {
        case name = "userName"
        case id
        case time
        case imageUrl = "userImageUrl"
        case videoUrl = "vUrl"
    }
}

struct Converter {
    var videos:[VideoListing]
}

extension Converter: Decodable {
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: Keys.self)
        let videos = try container.decode([VideoListing].self, forKey: .videos)
        self.init(videos:videos)
    }
    
    private enum Keys: String, CodingKey {
        case videos = "posts"
    }
}

