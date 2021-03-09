//
//  CommentCellViewModel.swift
//  Photo List
//
//  Created by Nick Koster on 09/03/2021.
//

import Foundation

struct CommentCellViewModel {
    var id: Int
    var name: String
    var body: String
    
    init(model: Comment) {
        id = model.id
        name = model.name
        body = model.body
    }
}
