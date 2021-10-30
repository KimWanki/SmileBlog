//
//  UIStackView+.swift
//  SmileBlog
//
//  Created by WANKI KIM on 2021/10/30.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView..., autoResizing: Bool = false) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = autoResizing
            self.addArrangedSubview(view)
        }
    }
}
