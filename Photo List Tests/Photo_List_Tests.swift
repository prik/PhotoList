//
//  Photo_List_Tests.swift
//  Photo List Tests
//
//  Created by Nick Koster on 25/03/2021.
//

import XCTest
@testable import Photo_List

class Photo_List_Tests: XCTestCase {
    
    let apiService = MockApiService()

    func testFetchPhotos() throws {
        apiService.fetchPhotos() { [weak self] result in
            guard self != nil else { return }
            
                switch result {
                case .success(let photos):
                    XCTAssertEqual(photos.count, 3)

                case .failure(_): break
                    //
                }
        }
        
    }
}
