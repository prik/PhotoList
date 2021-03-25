//
//  PhotoCellViewController.swift
//  Photo List
//
//  Created by Nick Koster on 04/03/2021.
//

import UIKit
import PureLayout

class PhotoCellViewController: UITableViewCell {
    
    static let identifier = String(describing: self)
    
    // MARK: - Properties
    internal var viewModel: PhotoCellViewModel? {
        didSet {
            photoImage.setImage(imageUrl: viewModel?.thumbnailUrl)
            photoTitle.text = viewModel?.title.uppercaseFirstLetter()
        }
    }
    
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
    private func configurePhotoImage() {
        addSubview(photoImage)

        photoImage.autoAlignAxis(toSuperviewAxis: .horizontal)
        photoImage.autoPinEdge(.leading, to: .leading, of: self, withOffset: 12)
        photoImage.autoSetDimension(.height, toSize: 80)
        photoImage.autoSetDimension(.width, toSize: 115)
    }

    private func configurePhotoTitle() {
        addSubview(photoTitle)
        
        photoTitle.autoAlignAxis(toSuperviewAxis: .horizontal)
        photoTitle.autoPinEdge(.leading, to: .trailing, of: photoImage, withOffset: 20)
        photoTitle.autoSetDimension(.height, toSize: 80)
        photoTitle.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -12)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        photoTitle.text = nil
        photoImage.image = nil
    }
}
