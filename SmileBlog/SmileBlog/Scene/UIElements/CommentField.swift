//
//  CommentField.swift
//  SmileBlog
//
//  Created by WANKI KIM on 2021/11/03.
//

import UIKit

class CommentField: UIView {
    
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

extension CommentField: ViewConfiguration {
    func buildHierarchy() {
        self.addSubviews(commentTextField, addButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            commentTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            commentTextField.topAnchor.constraint(equalTo: self.topAnchor),
            commentTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            commentTextField.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: 20),
            
            addButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            addButton.topAnchor.constraint(equalTo: self.topAnchor),
            addButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
