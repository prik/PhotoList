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
        table.register(CommentCell.self, forCellReuseIdentifier: CommentCell.identifier)
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
        
        photoImage.autoPinEdge(toSuperviewSafeArea: .top)
        photoImage.autoPinEdge(.leading, to: .leading, of: view)
        photoImage.autoPinEdge(.trailing, to: .trailing, of: view)
        photoImage.autoSetDimension(.height, toSize: 300.0)
    }
    
    func configurePhotoTitle() {
        view.addSubview(photoTitle)

        photoTitle.text = viewModel!.title.uppercaseFirstLetter()
        
        photoTitle.autoPinEdge(.top, to: .bottom, of: photoImage)
        photoTitle.autoPinEdge(.leading, to: .leading, of: view, withOffset: 10.0)
        photoTitle.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -10.0)
        photoTitle.autoSetDimension(.height, toSize: 80.0)
    }
    
    func configureCommentLabel() {
        view.addSubview(commentsLabel)
        
        commentsLabel.text = "Comments"
        
        commentsLabel.autoPinEdge(.leading, to: .leading, of: view, withOffset: 23.0)
        commentsLabel.autoPinEdge(.trailing, to: .trailing, of: view)
        commentsLabel.autoSetDimension(.height, toSize: 13.0)
        commentsLabel.autoPinEdge(.bottom, to: .top, of: commentList, withOffset: -7.5)
    }
    
    func configureCommentList() {
        view.addSubview(commentList)
        
        commentList.autoPinEdge(.top, to: .bottom, of: photoTitle, withOffset: 15.0)
        commentList.autoPinEdges(toSuperviewMarginsExcludingEdge: .top)
        
        setCommentListDelegates()
    }
    
}

