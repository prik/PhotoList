//
//  PhotoDetailViewModel.swift
//  Photo List
//
//  Created by Nick Koster on 09/03/2021.
//

import UIKit

protocol PhotoDetailViewModelDelegate {
    var commentList: UITableView { get }

    func didStartFetchingComments()
    func didFinishFetchingComments()
    func didFetchCommentsWithSuccess(_ comments: [Comment])
    func didFetchCommentsWithFailure(message: String)
}

class PhotoDetailViewModel {
    var photoDetailViewModelDelegate: PhotoDetailViewModelDelegate?
    let apiService: ApiServiceProtocol
    let maxCommentsToBeShown: Int
    
    let id: Int
    let title: String
    let imageUrl: String
    var comments: [Comment] = []
    
    init(model: Photo, apiService: ApiServiceProtocol, maxCommentsToBeShown: Int = 20) {
        id = model.id
        title = model.title
        imageUrl = model.imageUrl
        self.apiService = apiService
        self.maxCommentsToBeShown = maxCommentsToBeShown
    }
    
    func fetchComments() {
        startLoading()
        
        apiService.fetchComments(forPhotoId: id) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let comments):
                    self.comments = comments
                    self.orderCommentsByIdAscending()
                    self.limitCommentCountToMaxAmount()

                    self.photoDetailViewModelDelegate?.didFetchCommentsWithSuccess(self.comments)
                
                case .failure(_):
                    let message = "Something went wrong while fetching the comments. Make sure that you are connected to the internet."
                    self.photoDetailViewModelDelegate?.didFetchCommentsWithFailure(message: message)
                }
                
                self.photoDetailViewModelDelegate?.didFinishFetchingComments()
            }
        }
    }

    private func orderCommentsByIdAscending() {
        comments.sort(by: {$0.id < $1.id})
    }
    
    private func limitCommentCountToMaxAmount() {
        comments = Array(comments[..<maxCommentsToBeShown])
    }
    
    private func startLoading() {
        // Don't show the refresh loader and main loader simultaneously
        if let refreshControl = photoDetailViewModelDelegate?.commentList.refreshControl {
            if !refreshControl.isRefreshing {
                photoDetailViewModelDelegate?.didStartFetchingComments()
            }
        }
    }
}
