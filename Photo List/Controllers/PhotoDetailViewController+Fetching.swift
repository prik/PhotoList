//
//  PhotoDetailViewController+Fetching.swift
//  Photo List
//
//  Created by Nick Koster on 09/03/2021.
//

import Foundation

extension PhotoDetailViewController {
    
    func fetchComments() {
        
        // Don't show 2 loaders simultaneously
        if !self.commentList.refreshControl!.isRefreshing {
            LoadingHUD.show(forView: commentList)
        }
        
        ApiService().fetchComments(forPhotoId: viewModel!.id) { [weak self] result in
            guard let self = self else { return }
            
            LoadingHUD.hide(forView: self.commentList)
            
            switch result {
            case .success(let comments):
                DispatchQueue.main.async {
                    self.updateCommentList(with: comments)
                }
            case .failure(_):
                let alert = Alert.error(withMessage: "A problem occurred while fetching the images. Make sure that you are connected to the internet.")
                self.present(alert, animated: true)
            }
        }
    }
    
    func updateCommentList(with comments: [Comment]) {
        self.comments = comments
        self.comments.sort(by: {$0.id < $1.id}) // Sort ID A-Z
        self.comments = Array(self.comments[...19])
        commentList.reloadData()
    }
}
