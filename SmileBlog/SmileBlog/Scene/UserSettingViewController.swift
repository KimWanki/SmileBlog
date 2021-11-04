//
//  UserSettingViewController.swift
//  SmileBlog
//
//  Created by WANKI KIM on 2021/11/04.
//

import UIKit

class UserSettingViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        return UILabel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyViewSettings()
    }
}

// MARK: - ViewConfiguraion
extension UserSettingViewController: ViewConfiguration {
    func buildHierarchy() {
        self.view.addSubviews(titleLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    func configureViews() {
        titleLabel.text = "사용자 설정창"
    }
}
