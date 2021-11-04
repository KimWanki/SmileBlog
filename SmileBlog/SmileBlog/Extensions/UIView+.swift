//
//  UIView+.swift
//  SmileBlog
//
//  Created by WANKI KIM on 2021/10/30.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView..., autoResizing: Bool = false) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = autoResizing
            self.addSubview(view)
        }
    }
}
