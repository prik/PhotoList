//
//  ApiFetcher.swift
//  Photo List
//
//  Created by Nick Koster on 08/03/2021.
//

import Foundation
import Alamofire

class ApiService {
    
    private let apiBaseUrl = "https://jsonplaceholder.typicode.com"
    
    func fetchPhotos(completed: @escaping (Result<[Photo], Error>) -> Void) {
        AF.request(self.apiBaseUrl + "/photos").responseDecodable(of: [Photo].self) { response in
            guard let photos = response.value else {
                if let error = response.error {
                    completed(.failure(error))
                }
                return
            }
            
            completed(.success(photos))
        }
    }
    
    func fetchComments(forPhotoId photoId: Int, completed: @escaping (Result<[Comment], Error>) -> Void) {
        AF.request(self.apiBaseUrl + "/photos/" + String(photoId) + "/comments").responseDecodable(of: [Comment].self) { response in
            guard let comments = response.value else {
                if let error = response.error {
                    completed(.failure(error))
                }
                return
            }
            
            completed(.success(comments))
        }
    }
}
