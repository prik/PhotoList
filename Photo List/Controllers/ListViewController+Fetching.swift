//
//  ListViewController+Fetching.swift
//  Photo List
//
//  Created by Nick Koster on 09/03/2021.
//

import Foundation

extension ListViewController {
    func fetchPhotos() {
        // Don't show 2 loaders simultaneously
        if !self.photoList.refreshControl!.isRefreshing {
            LoadingHUD.show(forView: view)
        }
        
        ApiService().fetchPhotos { [weak self] result in
            guard let self = self else { return }
            
            LoadingHUD.hide(forView: self.view)
            
            switch result {
            case .success(let photos):
                DispatchQueue.main.async {
                    self.updatePhotoList(with: photos)
                }
            
            case .failure(_):
                let alert = Alert.error(withMessage: "A problem occurred while fetching the images. Make sure that you are connected to the internet.")
                self.present(alert, animated: true)
            }
        }
    }
    
    private func updatePhotoList(with photos: [Photo]) {
        self.photos = photos
        self.photos.sort(by: {$0.title < $1.title}) // Sort title A-Z
        self.photoList.reloadData()
    }
}
