//
//  PhotoCellViewModel.swift
//  Photo List
//
//  Created by Nick Koster on 09/03/2021.
//

import Foundation

struct PhotoCellViewModel {
    let title: String
    let thumbnailUrl: String
    
    init(model: Photo) {
        title = model.title
        thumbnailUrl = model.thumbnailUrl
    }
}
