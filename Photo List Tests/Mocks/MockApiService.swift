//
//  MockApiService.swift
//  Photo List Tests
//
//  Created by Nick Koster on 25/03/2021.
//

import Foundation
@testable import Photo_List

class MockApiService {
    let fetchPhotosResponse = """
        [
          {
            "albumId": 1,
            "id": 1,
            "title": "accusamus beatae ad facilis cum similique qui sunt",
            "url": "https://via.placeholder.com/600/92c952",
            "thumbnailUrl": "https://via.placeholder.com/150/92c952"
          },
          {
            "albumId": 1,
            "id": 2,
            "title": "reprehenderit est deserunt velit ipsam",
            "url": "https://via.placeholder.com/600/771796",
            "thumbnailUrl": "https://via.placeholder.com/150/771796"
          },
          {
            "albumId": 1,
            "id": 3,
            "title": "officia porro iure quia iusto qui ipsa ut modi",
            "url": "https://via.placeholder.com/600/24f355",
            "thumbnailUrl": "https://via.placeholder.com/150/24f355"
          }
        ]
    """
}

extension MockApiService: ApiServiceProtocol {
    func fetchPhotos(completed: @escaping (Result<[Photo], Error>) -> Void) {
        
        guard let jsonData = fetchPhotosResponse.data(using: .utf8) else { return }
       
        do {
            let photos: [Photo] = try JSONDecoder().decode([Photo].self, from: jsonData)
            
            completed(.success(photos))
        } catch {
            return
        }
    }
    
    func fetchComments(forPhotoId photoId: Int, completed: @escaping (Result<[Comment], Error>) -> Void) {
        //
    }
}
