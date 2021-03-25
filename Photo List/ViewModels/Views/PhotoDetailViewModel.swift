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
    func didFetchCommentsWithFailure(_ alert: UIAlertController)
}

class PhotoDetailViewModel {
    var photoDetailViewModelDelegate: PhotoDetailViewModelDelegate?
    let maxCommentsToBeShown = 20
    
    let id: Int
    let title: String
    let imageUrl: String
    var comments: [Comment] = []
    
    init(model: Photo) {
        id = model.id
        title = model.title
        imageUrl = model.imageUrl
    }
    
    func fetchComments() {
        startLoading()
        
        ApiService().fetchComments(forPhotoId: id) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let comments):
                    self.comments = comments
                    self.orderCommentsByIdAscending()
                    self.limitCommentCountToMaxAmount()

                    self.photoDetailViewModelDelegate?.didFetchCommentsWithSuccess(self.comments)
                
                case .failure(_):
                    let alert = Alert.error(withMessage: "A problem occurred while fetching the comments. Make sure that you are connected to the internet.")
                    
                    self.photoDetailViewModelDelegate?.didFetchCommentsWithFailure(alert)
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