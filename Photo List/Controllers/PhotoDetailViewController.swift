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
    private var headerView = UIView()
    private let photoImage = UIImageView()
    var comments: [Comment] = []

    private var photoTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let commentsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray3
        return label
    }()
    
    let commentList: UITableView = {
        let table = UITableView()
        table.allowsSelection = false
        table.separatorStyle = .none
        table.rowHeight = 135
        table.register(CommentCell.self, forCellReuseIdentifier: CommentCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    
        configureHeaderView()
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
        
    private func configureHeaderView() {
        self.headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 393))
    }
   
    private func configurePhotoImage() {
        guard let imageUrl = viewModel?.imageUrl else { return }

        headerView.addSubview(photoImage)
        photoImage.setImage(imageUrl: imageUrl)
        
        photoImage.configureForAutoLayout()
        photoImage.autoPinEdge(toSuperviewSafeArea: .top)
        photoImage.autoPinEdge(.leading, to: .leading, of: headerView)
        photoImage.autoPinEdge(.trailing, to: .trailing, of: headerView)
        photoImage.autoSetDimension(.height, toSize: 300)
    }
    
    private func configurePhotoTitle() {
        guard let title = viewModel?.title else { return }

        headerView.addSubview(photoTitle)
        photoTitle.text = title.uppercaseFirstLetter()
        
        photoTitle.autoPinEdge(.top, to: .bottom, of: photoImage)
        photoTitle.autoPinEdge(.leading, to: .leading, of: headerView, withOffset: 10)
        photoTitle.autoPinEdge(.trailing, to: .trailing, of: headerView, withOffset: -10)
        photoTitle.autoSetDimension(.height, toSize: 80)
    }
    
    private func configureCommentLabel() {
        headerView.addSubview(commentsLabel)
        commentsLabel.text = "Comments"
        
        commentsLabel.configureForAutoLayout()
        commentsLabel.autoPinEdge(.leading, to: .leading, of: headerView, withOffset: 33)
        commentsLabel.autoPinEdge(.trailing, to: .trailing, of: headerView)
        commentsLabel.autoSetDimension(.height, toSize: 13)
        commentsLabel.autoPinEdge(.bottom, to: .bottom, of: headerView)
    }
    
    private func configureCommentList() {
        view.addSubview(commentList)
        
        commentList.frame = view.bounds
        commentList.tableHeaderView = headerView
        
        setCommentListDelegates()
    }
    
}

