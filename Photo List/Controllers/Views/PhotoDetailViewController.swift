//
//  PhotoDetailViewController.swift
//  Photo List
//
//  Created by Nick Koster on 04/03/2021.
//

import UIKit
import PureLayout

// MARK: - Main Configuration
class PhotoDetailViewController: UIViewController {
    var viewModel: PhotoDetailViewModel?
    var comments: [Comment] = []
    private var headerView = UIView()
    private let photoImage = UIImageView()

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
        table.register(CommentCellViewController.self, forCellReuseIdentifier: CommentCellViewController.identifier)
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
        
        viewModel?.photoDetailViewModelDelegate = self
        viewModel?.fetchComments()
    }
    
    func configureViewModel(_ viewModel: PhotoDetailViewModel) {
        self.viewModel = viewModel
    }
        
    private func configureHeaderView() {
        self.headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 393))
    }
   
    private func configurePhotoImage() {
        headerView.addSubview(photoImage)
        photoImage.setImage(imageUrl: viewModel?.imageUrl)
        
        photoImage.configureForAutoLayout()
        photoImage.autoPinEdge(toSuperviewSafeArea: .top)
        photoImage.autoPinEdge(.leading, to: .leading, of: headerView)
        photoImage.autoPinEdge(.trailing, to: .trailing, of: headerView)
        photoImage.autoSetDimension(.height, toSize: 300)
    }
    
    private func configurePhotoTitle() {
        headerView.addSubview(photoTitle)
        photoTitle.text = viewModel?.title.uppercaseFirstLetter()
        
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

// MARK: - TableView Delegate Methods
extension PhotoDetailViewController: UITableViewDelegate, UITableViewDataSource {
    private func setCommentListDelegates() {
        commentList.delegate = self
        commentList.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentCellViewController.identifier) as? CommentCellViewController else {
            return UITableViewCell()
        }
        
        let viewModel = CommentCellViewModel(model: comments[indexPath.row])
        cell.configureViewModel(viewModel)
        
        return cell
    }
}

// MARK: - ViewModel Delegate Methods
extension PhotoDetailViewController: PhotoDetailViewModelDelegate {
    func didStartFetchingComments() {
        LoadingHUD.show(forView: commentList)
    }
    
    func didFinishFetchingComments() {
        LoadingHUD.hide(forView: commentList)
    }
    
    func didFetchCommentsWithSuccess(_ comments: [Comment]) {
        self.comments = comments
        commentList.reloadData()
    }
    
    func didFetchCommentsWithFailure(_ alert: UIAlertController) {
        present(alert, animated: true)
    }
}

// MARK: - Refresh Control
extension PhotoDetailViewController {
    private func configureRefreshControl() {
        commentList.refreshControl = UIRefreshControl()
        commentList.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
        
    @objc private func handleRefreshControl() {
        viewModel?.fetchComments()

        DispatchQueue.main.async {
            self.commentList.refreshControl?.endRefreshing()
        }
    }
}
