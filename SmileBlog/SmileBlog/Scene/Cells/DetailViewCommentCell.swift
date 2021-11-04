//
//  DetailViewCommentCell.swift
//  SmileBlog
//
//  Created by WANKI KIM on 2021/11/03.
//

import UIKit

final class DetailViewCommentCell: UITableViewCell {
    enum Constant {
        static let userImageSize: CGFloat = 25
        static let inset: CGFloat = 10
    }
    
    static let reusableIdentifier = "\(DetailViewController.self)"
    
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.fill")
        return imageView
    }()
    
    private lazy var nickNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var commentLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var userInfoStackView: UIStackView = {
        let userInfoStack = UIStackView()
        userInfoStack.axis = .horizontal
        return userInfoStack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        applyViewSettings()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyViewSettings()
    }
}

// MARK: - View Configuration
extension DetailViewCommentCell: ViewConfiguration {
    func buildHierarchy() {
        userInfoStackView.addArrangedSubviews(userImageView, nickNameLabel)
        contentView.addSubviews(userInfoStackView, commentLabel, dateLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            userImageView.widthAnchor.constraint(equalToConstant: Constant.userImageSize),
            userImageView.heightAnchor.constraint(equalToConstant: Constant.userImageSize),
            
            userInfoStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constant.inset),
            userInfoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.inset),
            userInfoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.inset),
            userInfoStackView.bottomAnchor.constraint(equalTo: commentLabel.topAnchor, constant: -Constant.inset),
            
            commentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.inset),
            commentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.inset),
            commentLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -Constant.inset),
            
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.inset),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.inset),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constant.inset)
        ])
    }
    
    func configureViews() {
        self.selectedBackgroundView = {
            let background = UIView()
            background.backgroundColor = .clear
            return background
        }()
        userImageView.tintColor = .gray
        commentLabel.numberOfLines = -1
        
        nickNameLabel.font = .preferredFont(forTextStyle: .body)
        
        dateLabel.textColor = .darkGray
        dateLabel.font = .preferredFont(forTextStyle: .footnote)
        
        commentLabel.font = .preferredFont(forTextStyle: .body)
    }
}

extension DetailViewCommentCell {
    func configure(_ comment: Comment) {
        self.nickNameLabel.text = comment.user
        self.commentLabel.text = comment.content
        self.dateLabel.text = comment.date
    }
}
