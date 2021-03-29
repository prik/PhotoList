//
//  ApiServiceProtocol.swift
//  Photo List
//
//  Created by Nick Koster on 25/03/2021.
//

import Foundation

protocol ApiServiceProtocol {
    func fetchPhotos(completed: @escaping (Result<[Photo], Error>) -> Void)
    func fetchComments(forPhotoId photoId: Int, completed: @escaping (Result<[Comment], Error>) -> Void)
}
