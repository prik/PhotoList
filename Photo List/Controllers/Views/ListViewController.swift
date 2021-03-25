//
//  ListViewController.swift
//  Photo List
//
//  Created by Nick Koster on 08/03/2021.
//

import UIKit
import NotificationBannerSwift

// MARK: - Main Configuration
class ListViewController: UIViewController {
    var viewModel: ListViewModel
    var refreshControl: UIRefreshControl?
    
    let photoList: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.rowHeight = 100
        table.register(PhotoCellViewController.self, forCellReuseIdentifier: PhotoCellViewController.identifier)
        return table
    }()
    
    init(withViewModel model: ListViewModel) {
        viewModel = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePhotoList()
        configureRefreshControl()
        
        viewModel.listViewModelDelegate = self
        viewModel.fetchPhotos()
    }
    
    private func configurePhotoList() {
        title = viewModel.menuTitle
        photoList.frame = view.bounds
        view.addSubview(photoList)
        setTableViewDelegates()
    }
}

// MARK: - TableView Delegate Methods
extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    private func setTableViewDelegates() {
        photoList.delegate = self
        photoList.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCellViewController.identifier) as? PhotoCellViewController else {
            return UITableViewCell()
        }
        
        cell.viewModel = PhotoCellViewModel(model: viewModel.photos[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
        
        let photoDetailViewModel = PhotoDetailViewModel(model: viewModel.photos[selectedIndexPath.row])
        let photoDetail = PhotoDetailViewController(withViewModel: photoDetailViewModel)
        
        navigationController?.pushViewController(photoDetail, animated: true)
        tableView.cellForRow(at: indexPath)?.selectionStyle = .none
    }
}

// MARK: - ViewModel Delegate Methods
extension ListViewController: ListViewModelDelegate {
    func didStartFetchingPhotos() {
        LoadingHUD.show(forView: view)
    }
    
    func didFinishFetchingPhotos() {
        LoadingHUD.hide(forView: view)
    }
    
    func didFetchPhotosWithSuccess(_ photos: [Photo]) {
        photoList.reloadData()
    }
    
    func didFetchPhotosWithFailure(message: String) {
        let notification = GrowingNotificationBanner.init(title: "Error", subtitle: message, style: .danger)
        notification.show()
    }
}

// MARK: - Refresh Control
extension ListViewController {
    func configureRefreshControl() {
        photoList.refreshControl = UIRefreshControl()
        photoList.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
        
    @objc private func handleRefreshControl() {
        viewModel.fetchPhotos()
        self.photoList.refreshControl?.endRefreshing()
    }
}
