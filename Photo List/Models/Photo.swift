//
//  Photo.swift
//  Photo List
//
//  Created by Nick Koster on 04/03/2021.
//

import Foundation

struct Photo: Decodable {
    let id: Int
    let title: String
    var imageUrl: String
    let thumbnailUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case imageUrl = "url"
        case thumbnailUrl
    }
}
