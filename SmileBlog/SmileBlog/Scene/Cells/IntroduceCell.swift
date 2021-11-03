//
//  IntroduceCell.swift
//  SmileBlog
//
//  Created by WANKI KIM on 2021/11/02.
//

import UIKit

class IntroduceCell: UITableViewCell {
    enum Constant {
        static let verticalInset: CGFloat = 5
        static let leadingInset: CGFloat = 20
        static let trailingInset: CGFloat = 10
    }
    
    static let reuseIdentifier = "\(IntroduceCell.self)"
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = """
        iOS 를 좋아하는 개발자 루얀입니다.
        ML 🍏 IOS
        """
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

extension IntroduceCell: ViewConfiguration {
    func buildHierarchy() {
        contentView.addSubviews(titleLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constant.verticalInset),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constant.verticalInset),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.leadingInset),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.trailingInset)
        ])
    }
    
    func configureViews() {
        self.backgroundColor = .white
        self.selectionStyle = .none
    }
}
