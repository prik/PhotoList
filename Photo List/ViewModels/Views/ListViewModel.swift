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
    func didFetchPhotosWithFailure(message: String)
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
            
            DispatchQueue.main.async {
                switch result {
                case .success(let photos):
                    self.photos = photos
                    self.orderPhotosByNameAscending()
                    self.listViewModelDelegate?.didFetchPhotosWithSuccess(self.photos)
                    
                case .failure(_):
                    let message = "Something went wrong while fetching the images. Make sure that you are connected to the internet."
                    self.listViewModelDelegate?.didFetchPhotosWithFailure(message: message)
                }
                
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
