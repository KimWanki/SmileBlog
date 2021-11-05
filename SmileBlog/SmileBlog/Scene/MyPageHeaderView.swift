//
//  MyPageHeaderView.swift
//  SmileBlog
//
//  Created by WANKI KIM on 2021/11/05.
//

import UIKit

class MyPageHeaderView: UIView {
    enum Constant {
        static let imageSize: CGFloat = 120
        
    }
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.fill")
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constant.imageSize / 2
        imageView.tintColor = .gray
        return imageView
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
extension MyPageHeaderView: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(profileImage)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: Constant.imageSize),
            profileImage.heightAnchor.constraint(equalToConstant: Constant.imageSize)
        ])
        
    }
    
    
}
