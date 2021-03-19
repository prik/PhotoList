//
//  PhotoCell.swift
//  Photo List
//
//  Created by Nick Koster on 04/03/2021.
//

import UIKit
import PureLayout

class PhotoCell: UITableViewCell {
    
    static let identifier = String(describing: self)
    
    // MARK: - Properties
    private var viewModel: PhotoCellViewModel?
    
    var photoImage: UIImageView = {
        let image = UIImageView().configureForAutoLayout()
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    var photoTitle: UILabel = {
        let title = UILabel().configureForAutoLayout()
        title.numberOfLines = 0
        title.adjustsFontSizeToFitWidth = true
        return title
    }()
    

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        configurePhotoImage()
        configurePhotoTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    func configureViewModel(with viewModel: PhotoCellViewModel) {
        self.viewModel = viewModel
        
        photoImage.setImage(imageUrl: self.viewModel!.thumbnailUrl)
        photoTitle.text = self.viewModel?.title.uppercaseFirstLetter()
    }
    
    private func configurePhotoImage() {
        addSubview(photoImage)

        photoImage.autoAlignAxis(toSuperviewAxis: .horizontal)
        photoImage.autoPinEdge(.leading, to: .leading, of: self, withOffset: 12.0)
        photoImage.autoSetDimension(.height, toSize: 80.0)
        photoImage.autoSetDimension(.width, toSize: 115.0)
    }

    private func configurePhotoTitle() {
        addSubview(photoTitle)
        
        photoTitle.autoAlignAxis(toSuperviewAxis: .horizontal)
        photoTitle.autoPinEdge(.leading, to: .trailing, of: photoImage, withOffset: 20.0)
        photoTitle.autoSetDimension(.height, toSize: 80.0)
        photoTitle.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -12.0)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        photoTitle.text = nil
        photoImage.image = nil
    }
}
