//
//  Comment.swift
//  Photo List
//
//  Created by Nick Koster on 06/03/2021.
//

import Foundation

struct Comment: Decodable {
    var id: Int
    var name: String
    var email: String
    var body: String
}
