//
//  ListViewController.swift
//  Photo List
//
//  Created by Nick Koster on 08/03/2021.
//

import UIKit

class ListViewController: UIViewController {
    
    var photos: [Photo] = []
    private let pageTitle = "Photo List"
    
    let photoList: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.rowHeight = 100
        table.register(PhotoCell.self, forCellReuseIdentifier: PhotoCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePhotoList()
        configureRefreshControl()
        
        fetchPhotos()
    }
    
    private func configurePhotoList() {
        title = pageTitle

        photoList.frame = view.bounds
        setTableViewDelegates()
        view.addSubview(photoList)
    }
}
