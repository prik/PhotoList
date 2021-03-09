//
//  UIImageView+SetImage.swift
//  Photo List
//
//  Created by Nick Koster on 04/03/2021.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(imageUrl: String) {
        self.kf.indicatorType = .activity // Show a spinner while loading
        self.kf.setImage(with: URL(string: imageUrl)) { result in
            switch result {
            case .success(_):
                break
            case .failure(_):
                self.image = UIImage(systemName: "wifi.slash")
            }
        }
    }
}
