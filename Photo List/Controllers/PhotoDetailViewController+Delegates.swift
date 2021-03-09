//
//  PhotoDetailViewController+Delegates.swift
//  Photo List
//
//  Created by Nick Koster on 08/03/2021.
//

import UIKit

extension PhotoDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setCommentListDelegates() {
        commentList.delegate = self
        commentList.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.commentCell) as! CommentCell
        let viewModel = CommentCellViewModel(model: comments[indexPath.row])
        cell.configureViewModel(with: viewModel)
        return cell
    }
}
