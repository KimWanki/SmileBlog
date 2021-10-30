//
//  UIView+.swift
//  SmileBlog
//
//  Created by WANKI KIM on 2021/10/30.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
        }
    }
}
