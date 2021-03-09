//
//  PhotoDetailViewControllerViewModel.swift
//  Photo List
//
//  Created by Nick Koster on 09/03/2021.
//

import Foundation

struct PhotoDetailViewControllerViewModel {
    let id: Int
    let title: String
    let imageUrl: String
    
    init(model: Photo) {
        id = model.id
        title = model.title
        imageUrl = model.imageUrl
    }
}
