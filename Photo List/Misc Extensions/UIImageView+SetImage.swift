//
//  UIImageView+SetImage.swift
//  Photo List
//
//  Created by Nick Koster on 04/03/2021.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(imageUrl: String?) {
        guard let imageUrl = imageUrl else {
            self.image = UIImage(systemName: "wifi.slash")
            return
        }
        
        self.kf.indicatorType = .activity // Show a spinner while loading
        self.kf.setImage(with: URL(string: imageUrl)) { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                // Make sure that we only set the error image when there is a download error
                if error.isTaskCancelled || error.isNotCurrentTask {
                    return
                }

                self.image = UIImage(systemName: "wifi.slash")
            }
        }
    }
}
