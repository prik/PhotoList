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
    var viewModel: ListViewModel?
    var photos: [Photo] = []
    var refreshControl: UIRefreshControl?
    
    let photoList: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.rowHeight = 100
        table.register(PhotoCellViewController.self, forCellReuseIdentifier: PhotoCellViewController.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        guard let viewModel = viewModel else { return }
        super.viewDidLoad()
        
        configurePhotoList()
        configureRefreshControl()
        
        viewModel.listViewModelDelegate = self
        viewModel.fetchPhotos()
    }
    
    private func configurePhotoList() {
        title = viewModel?.menuTitle
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
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCellViewController.identifier) as? PhotoCellViewController else {
            return UITableViewCell()
        }
        
        let viewModel = PhotoCellViewModel(model: photos[indexPath.row])
        cell.configureViewModel(viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
        
        let photoDetail = PhotoDetailViewController()
        let viewModel = PhotoDetailViewModel(model: photos[selectedIndexPath.row])
        
        photoDetail.configureViewModel(viewModel)
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
        self.photos = photos
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
        viewModel?.fetchPhotos()
        self.photoList.refreshControl?.endRefreshing()
    }
}
