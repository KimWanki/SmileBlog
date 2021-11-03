//
//  DetailViewTitleCell.swift
//  SmileBlog
//
//  Created by WANKI KIM on 2021/11/03.
//

import UIKit

class DetailViewContentCell: UITableViewCell {
    enum Constant {
        static let inset: CGFloat = 20
    }
    
    static let reuseIdentifier = "\(DetailViewContentCell.self)"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = -1
        return label
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

extension DetailViewContentCell: ViewConfiguration {
    func buildHierarchy() {
        contentView.addSubviews(titleLabel, dateLabel, contentLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.inset),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.inset),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constant.inset),
            titleLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor),
            
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.inset),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.inset),
            dateLabel.bottomAnchor.constraint(equalTo: contentLabel.topAnchor, constant: -Constant.inset),
            
            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.inset),
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.inset),
            contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constant.inset)
        ])
    }
}

extension DetailViewContentCell {
    func configure(_ post: Post) {
        self.titleLabel.text = post.title
        self.contentLabel.text = post.content
        self.dateLabel.text = post.date
    }
}
