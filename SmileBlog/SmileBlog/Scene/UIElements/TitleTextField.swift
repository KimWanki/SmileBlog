//
//  TitleTextField.swift
//  SmileBlog
//
//  Created by WANKI KIM on 2021/11/03.
//

import UIKit

final class TitleTextField: UITextField {

    private lazy var underlintView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .gray
        
        return uiView
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

// MARK: View Configuration
extension TitleTextField: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(underlintView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            underlintView.leadingAnchor.constraint(equalTo: leadingAnchor),
            underlintView.trailingAnchor.constraint(equalTo: trailingAnchor),
            underlintView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
            underlintView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func configureViews() {
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [.foregroundColor : UIColor(white: 1, alpha: 0.3)])
    }
}
