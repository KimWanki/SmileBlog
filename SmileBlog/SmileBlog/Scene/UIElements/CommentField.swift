//
//  CommentField.swift
//  SmileBlog
//
//  Created by WANKI KIM on 2021/11/03.
//

import UIKit

final class CommentField: UIView {
    enum Constant {
        static let inset: CGFloat = 20
        static let addButtonWidth: CGFloat = 100
    }
    
    lazy var commentTextField: UITextField  = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = "댓글을 입력하세요."
        return textField
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paperplane"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewSettings()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyViewSettings()
    }
}

// MARK: - ViewConfiguration
extension CommentField: ViewConfiguration {
    func buildHierarchy() {
        self.addSubviews(commentTextField, addButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            commentTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constant.inset),
            commentTextField.topAnchor.constraint(equalTo: self.topAnchor),
            commentTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            commentTextField.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: Constant.inset),
            
            addButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constant.inset),
            addButton.topAnchor.constraint(equalTo: self.topAnchor),
            addButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            addButton.widthAnchor.constraint(equalToConstant: Constant.addButtonWidth)
        ])
    }
    
    func configureViews() {
        addButton.tintColor = .gray
    }
}
