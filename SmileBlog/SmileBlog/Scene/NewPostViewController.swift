//
//  NewPostViewController.swift
//  SmileBlog
//
//  Created by WANKI KIM on 2021/11/03.
//

import UIKit

class NewPostViewController: UIViewController {
    enum Constant {
        static let leadingInset: CGFloat = 20
    }
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
    
    private lazy var moveButton: UIButton = {
        let button = UIButton()
        button.setTitle("글 작성", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(touchButton), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        applyViewSettings()
    }
    
    @objc
    func touchButton() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension NewPostViewController: ViewConfiguration {
    func buildHierarchy() {
        view.addSubviews(titleLabel, moveButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            moveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            moveButton.centerYAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant:  20)
        ])
    }
}
