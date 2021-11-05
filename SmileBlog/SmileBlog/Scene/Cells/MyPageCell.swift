//
//  MyPageCell.swift
//  SmileBlog
//
//  Created by WANKI KIM on 2021/11/05.
//

import UIKit

final class MyPageCell: UITableViewCell {
    enum Constant {
        static let verticalInset: CGFloat = 5
        static let leadingInset: CGFloat = 20
        static let trailingInset: CGFloat = 10
    }
    
    static let reuseIdentifier = "\(MyPageCell.self)"
    
    private lazy var optionLabel: UILabel = {
        let label = UILabel()
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

extension MyPageCell: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(optionLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            optionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            optionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func configureViews() {
        self.accessoryType = .disclosureIndicator
    }
}

extension MyPageCell {
    func configure(_ option: String) {
        self.optionLabel.text = option
    }
}
