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
        
        // setNeedsUpdateConstraints() // PureLayout is sadly not working
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

        photoImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        photoImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        photoImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        photoImage.widthAnchor.constraint(equalToConstant: 115).isActive = true
    }

    private func configurePhotoTitle() {
        addSubview(photoTitle)
        
        photoTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        photoTitle.leadingAnchor.constraint(equalTo: photoImage.trailingAnchor, constant: 20).isActive = true
        photoTitle.heightAnchor.constraint(equalToConstant: 80).isActive = true
        photoTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    
    // I tried to use PureLayout, but somehow it just wouldn't work. The constraints were all off.
    // Leaving the code here for review
//    override func updateConstraints() {
//        photoImage.autoAlignAxis(toSuperviewAxis: .vertical)
//        photoImage.autoPinEdge(.leading, to: .leading, of: self, withOffset: 12.0)
//        photoImage.autoSetDimension(.height, toSize: 80.0)
//        photoImage.autoSetDimension(.width, toSize: 115.0)
//
//        super.updateConstraints()
//    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        photoTitle.text = nil
        photoImage.image = nil
    }
}
