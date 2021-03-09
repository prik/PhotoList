//
//  PhotoDetailViewController.swift
//  Photo List
//
//  Created by Nick Koster on 04/03/2021.
//

import UIKit
import Alamofire

class PhotoDetailViewController: UIViewController {
    
    var viewModel: PhotoDetailViewControllerViewModel?

    var comments: [Comment] = []
    var photoImage = UIImageView().configureForAutoLayout()
    
    var photoTitle: UILabel = {
        let label = UILabel().configureForAutoLayout()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let commentsLabel: UILabel = {
        let label = UILabel().configureForAutoLayout()
        label.font = .systemFont(ofSize: 12.0)
        label.textColor = .systemGray3
        return label
    }()
    
    let commentList: UITableView = {
        let table = UITableView().configureForAutoLayout()
        table.allowsSelection = false
        table.separatorStyle = .none
        table.rowHeight = UITableView.automaticDimension
        table.rowHeight = 130 // Somehow I cannot get dynamic height to work
        table.contentInset = UIEdgeInsets.init(top: 5.0, left: 0.0, bottom: 5.0, right: 0.0)
        table.register(CommentCell.self, forCellReuseIdentifier: CellIdentifier.commentCell)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    
        configurePhotoImage()
        configurePhotoTitle()
        configureCommentList()
        configureCommentLabel()
        configureRefreshControl()
        
        fetchComments()
    }
    
    func configureViewModel(with viewModel: PhotoDetailViewControllerViewModel) {
        self.viewModel = viewModel
    }
   
    func configurePhotoImage() {
        view.addSubview(photoImage)

        photoImage.setImage(imageUrl: viewModel!.imageUrl)

        photoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        photoImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        photoImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        photoImage.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    func configurePhotoTitle() {
        view.addSubview(photoTitle)

        photoTitle.text = viewModel!.title.uppercaseFirstLetter()
        
        photoTitle.topAnchor.constraint(equalTo: photoImage.bottomAnchor, constant: 0.0).isActive = true
        photoTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0).isActive = true
        photoTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0).isActive = true
        photoTitle.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func configureCommentLabel() {
        view.addSubview(commentsLabel)
        
        commentsLabel.text = "Comments"
        
        commentsLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 23.0).isActive = true
        commentsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        commentsLabel.heightAnchor.constraint(equalToConstant: 13.0).isActive = true
        commentsLabel.bottomAnchor.constraint(equalTo: commentList.topAnchor, constant: -7.5).isActive = true
    }
    
    func configureCommentList() {
        view.addSubview(commentList)
        
        commentList.topAnchor.constraint(equalTo: photoTitle.bottomAnchor, constant: 15.0).isActive = true
        commentList.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        commentList.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        commentList.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        setCommentListDelegates()
    }
    
}

