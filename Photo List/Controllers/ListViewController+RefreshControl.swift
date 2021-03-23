//
//  ListViewController+RefreshControl.swift
//  Photo List
//
//  Created by Nick Koster on 08/03/2021.
//

import UIKit

extension ListViewController {
    func configureRefreshControl() {
        photoList.refreshControl = UIRefreshControl()
        photoList.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
        
    @objc private func handleRefreshControl() {
        fetchPhotos()

        self.photoList.refreshControl?.endRefreshing()
    }
}
