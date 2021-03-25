//
//  ListViewModel.swift
//  Photo List
//
//  Created by Nick Koster on 20/03/2021.
//

import UIKit

protocol ListViewModelDelegate {
    var photoList: UITableView { get }
    
    func didStartFetchingPhotos()
    func didFinishFetchingPhotos()
    func didFetchPhotosWithSuccess(_ photos: [Photo])
}

class ListViewModel {
    var listViewModelDelegate: ListViewModelDelegate?
    
    var menuTitle: String
    var photos: [Photo] = []
    
    init(menuTitle: String) {
        self.menuTitle = menuTitle
    }
    
    func fetchPhotos() {
        startLoading()
        
        ApiService().fetchPhotos { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let photos):
                self.photos = photos
                self.orderPhotosByNameAscending()
                
                DispatchQueue.main.async {
                    self.listViewModelDelegate?.didFetchPhotosWithSuccess(self.photos)
                }
            
            case .failure(_): break
//                let alert = Alert.error(withMessage: "A problem occurred while fetching the images. Make sure that you are connected to the internet.")
//                self.present(alert, animated: true)
            }
            
            DispatchQueue.main.async {
                self.listViewModelDelegate?.didFinishFetchingPhotos()
            }
        }
    }
    
    private func orderPhotosByNameAscending() {
        photos.sort(by: {$0.title < $1.title})
    }
    
    private func startLoading() {
        // Don't show the refresh loader and main loader simultaneously
        if let refreshControl = listViewModelDelegate?.photoList.refreshControl {
            if !refreshControl.isRefreshing {
                listViewModelDelegate?.didStartFetchingPhotos()
            }
        }
    }
}
