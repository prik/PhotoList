//
//  CommentCellViewController.swift
//  Photo List
//
//  Created by Nick Koster on 06/03/2021.
//

import UIKit
import PureLayout

class CommentCellViewController: UITableViewCell {
    static let identifier = String(describing: self)
    
    // MARK: - Properties
    internal var viewModel: CommentCellViewModel? {
        didSet {
            idLabel.text = viewModel?.id
            nameLabel.text = viewModel?.name.uppercaseFirstLetter()
            commentLabel.text = viewModel?.body.uppercaseFirstLetter()
        }
    }
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 9, weight: .light)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
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
    private func configureIdLabel() {
        addSubview(idLabel)
        
        idLabel.configureForAutoLayout()
        idLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        idLabel.autoPinEdge(.leading, to: .leading, of: contentView, withOffset: 10)
        idLabel.autoMatch(.height, to: .height, of: contentView)
        idLabel.autoSetDimension(.width, toSize: 13)
    }
    
    private func configureNameLabel() {
        addSubview(nameLabel)

        nameLabel.configureForAutoLayout()
        nameLabel.autoPinEdge(.top, to: .top, of: contentView, withOffset: 6)
        nameLabel.autoPinEdge(.leading, to: .trailing, of: idLabel, withOffset: 10)
        nameLabel.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: -15)
        nameLabel.autoSetDimension(.height, toSize: 15)
    }
    
    private func configureCommentLabel() {
        addSubview(commentLabel)
        
        commentLabel.configureForAutoLayout()
        commentLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        commentLabel.autoPinEdge(.top, to: .bottom, of: nameLabel)
        commentLabel.autoPinEdge(.leading, to: .trailing, of: idLabel, withOffset: 10)
        commentLabel.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: -15)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        idLabel.text = nil
        nameLabel.text = nil
        commentLabel.text = nil
    }
}
