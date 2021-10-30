//
//  ViewConfiguration.swift
//  SmileBlog
//
//  Created by WANKI KIM on 2021/10/30.
//

import Foundation

protocol ViewConfiguration {
    func buildHierarchy()
    func setupConstraints()
    func configureViews()
}

extension ViewConfiguration {
    func configureViews() {}
    
    func applyViewSettings() {
        buildHierarchy()
        setupConstraints()
        configureViews()
    }
}
