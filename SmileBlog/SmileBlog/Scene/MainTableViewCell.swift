//
//  MainTableViewCell.swift
//  SmileBlog
//
//  Created by WANKI KIM on 2021/10/30.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    enum Constant {
        static let verticalInset: CGFloat = 5
        static let horizontalInset: CGFloat = 10
    }
    
    static let reuseIdentifier = "\(MainTableViewCell.self)"
    
    private lazy var titleLabel: UILabel = { return UILabel(frame: .zero) }()
    private lazy var contentLabel: UILabel = { return UILabel(frame: .zero) }()
    private lazy var dateLabel: UILabel = { return UILabel(frame: .zero) }()
    private lazy var commentCountLabel: UILabel = { return UILabel(frame: .zero) }()
    
    private lazy var vStackView: UIStackView = { return UIStackView(frame: .zero) }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        applyViewSettings()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyViewSettings()
    }
}

extension MainTableViewCell: ViewConfiguration {
    func buildHierarchy() {
        vStackView.addArrangedSubviews(titleLabel, contentLabel, dateLabel, commentCountLabel)
        contentView.addSubviews(vStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                            constant: Constant.verticalInset),
            vStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                               constant: -Constant.verticalInset),
            vStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                constant: Constant.horizontalInset),
            vStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                 constant: -Constant.horizontalInset)
        ])
    }
    
    func configureViews() {
        self.backgroundColor = .clear
        
        vStackView.axis = .vertical
        vStackView.alignment = .leading
        vStackView.distribution = .fillProportionally
        
        titleLabel.font = .preferredFont(forTextStyle: .title3)
        contentLabel.font = .preferredFont(forTextStyle: .body)
        dateLabel.font = .preferredFont(forTextStyle: .body)
        commentCountLabel.font = .preferredFont(forTextStyle: .footnote)
    }
}

extension MainTableViewCell {
    func configure(_ post: Post) {
        titleLabel.text = "타이틀"
        contentLabel.text = "글 내용"
        dateLabel.text = "날짜"
        commentCountLabel.text = "댓글 개수"
    }
}
