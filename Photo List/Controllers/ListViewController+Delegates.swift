//
//  ListViewController+Delegates.swift
//  Photo List
//
//  Created by Nick Koster on 08/03/2021.
//

import UIKit

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func setTableViewDelegates() {
        photoList.delegate = self
        photoList.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.photoCell) as! PhotoCell
        let viewModel = PhotoCellViewModel(model: photos[indexPath.row])
        cell.configureViewModel(with: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photoDetail = PhotoDetailViewController()
        let viewModel = PhotoDetailViewControllerViewModel(model: photos[tableView.indexPathForSelectedRow!.row])
        photoDetail.configureViewModel(with: viewModel)
        navigationController?.pushViewController(photoDetail, animated: true)
        tableView.cellForRow(at: indexPath)?.selectionStyle = .none
    }
}
