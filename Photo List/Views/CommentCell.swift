//
//  CommentCell.swift
//  Photo List
//
//  Created by Nick Koster on 06/03/2021.
//

import UIKit

class CommentCell: UITableViewCell {
    
    static let identifier = String(describing: self)
    
    // MARK: - Properties
    private var viewModel: CommentCellViewModel?
    
    let idLabel: UILabel = {
        let label = UILabel().configureForAutoLayout()
        label.font = .systemFont(ofSize: 9.0, weight: .light)
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel().configureForAutoLayout()
        label.font = .boldSystemFont(ofSize: 12.0)
        return label
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel().configureForAutoLayout()
        label.font = .systemFont(ofSize: 15.0)
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.autoresizesSubviews = true
        return label
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureIdLabel()
        configureNameLabel()
        configureCommentLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    func configureViewModel(with viewModel: CommentCellViewModel) {
        self.viewModel = viewModel
        
        idLabel.text = String(viewModel.id)
        nameLabel.text = self.viewModel?.name.uppercaseFirstLetter()
        commentLabel.text = self.viewModel?.body.uppercaseFirstLetter()
    }
    
    private func configureIdLabel() {
        addSubview(idLabel)
        
        idLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        idLabel.autoPinEdge(.leading, to: .leading, of: contentView)
        idLabel.autoMatch(.height, to: .height, of: contentView)
        idLabel.autoSetDimension(.width, toSize: 13.0)
    }
    
    private func configureNameLabel() {
        addSubview(nameLabel)

        nameLabel.autoPinEdge(.top, to: .top, of: contentView, withOffset: 6.0)
        nameLabel.autoPinEdge(.leading, to: .trailing, of: idLabel, withOffset: 10.0)
        nameLabel.autoPinEdge(.trailing, to: .trailing, of: contentView)
        nameLabel.autoSetDimension(.height, toSize: 15.0)
    }
    
    private func configureCommentLabel() {
        addSubview(commentLabel)
        
        commentLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        commentLabel.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: 1.0)
        commentLabel.autoPinEdge(.leading, to: .trailing, of: idLabel, withOffset: 10.0)
        commentLabel.autoMatch(.width, to: .width, of: contentView, withOffset: -23.0)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        idLabel.text = nil
        nameLabel.text = nil
        commentLabel.text = nil
    }
}
