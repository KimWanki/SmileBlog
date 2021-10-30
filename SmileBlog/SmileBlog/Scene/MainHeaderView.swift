//
//  MainHeaderView.swift
//  SmileBlog
//
//  Created by WANKI KIM on 2021/10/30.
//

import UIKit

class MainHeaderView: UIView {
    private var imageString: String = "headerViewImage"
    
    private lazy var imageView = {
        return UIImageView()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewSettings()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyViewSettings()
    }
    
    convenience init(frame: CGRect, image: String) {
        self.init(frame: frame)
        self.imageString = image
    }
}

extension MainHeaderView: ViewConfiguration {
    func buildHierarchy() {
        self.addSubviews(imageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    func configureViews() {
        imageView.image = UIImage(named: imageString)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
    }
}
