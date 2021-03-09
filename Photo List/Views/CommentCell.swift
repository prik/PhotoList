//
//  CommentCell.swift
//  Photo List
//
//  Created by Nick Koster on 06/03/2021.
//

import UIKit

class CommentCell: UITableViewCell {
    
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
        
        nameLabel.text = self.viewModel?.name.uppercaseFirstLetter()
        commentLabel.text = self.viewModel?.body.uppercaseFirstLetter()
    }
    
    private func configureIdLabel() {
        addSubview(idLabel)

        idLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        idLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        idLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        idLabel.widthAnchor.constraint(equalToConstant: 13.0).isActive = true
    }
    
    private func configureNameLabel() {
        addSubview(nameLabel)

        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6.0).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor, constant: 10.0).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 15.0).isActive = true
    }
    
    private func configureCommentLabel() {
        addSubview(commentLabel)
        
        commentLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 1.0).isActive = true
        commentLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        commentLabel.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor, constant: 10.0).isActive = true
        commentLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -23.0).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        idLabel.text = nil
        nameLabel.text = nil
        commentLabel.text = nil
    }
}
