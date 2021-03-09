//
//  PhotoDetailViewController+RefreshControl.swift
//  Photo List
//
//  Created by Nick Koster on 08/03/2021.
//

import UIKit

extension PhotoDetailViewController {
    func configureRefreshControl() {
        commentList.refreshControl = UIRefreshControl()
        commentList.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
        
    @objc func handleRefreshControl() {
        fetchComments()

        DispatchQueue.main.async {
            self.commentList.refreshControl?.endRefreshing()
        }
    }
}
