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
    
    private lazy var navigationBar: UINavigationBar = {
        let bar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))

        let navItem = UINavigationItem(title: "새 글 쓰기")
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                         target: self,
                                         action: #selector(clickCancelButton))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                       target: self,
                                       action: #selector(clickDoneButton))
        
        cancelButton.tintColor = .gray
        doneButton.tintColor = .gray
        
        navItem.leftBarButtonItem = cancelButton
        navItem.rightBarButtonItem = doneButton
        bar.setItems([navItem], animated: false)
        return bar
    }()
    
    private lazy var titleTextField: TitleTextField = {
        let textField = TitleTextField(frame: .zero)
        textField.placeholder = "제목"
        textField.font = .preferredFont(forTextStyle: .title3)
        return textField
    }()
    
    private lazy var contentTextView: UITextView = {
        let textView = UITextView()
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        applyViewSettings()
    }
    
    @objc
    func clickCancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func clickDoneButton() {
        // TODO: DB에 새로운 글 저장
        self.dismiss(animated: true, completion: nil)
    }
}

extension NewPostViewController: ViewConfiguration {
    func buildHierarchy() {
        view.addSubviews(navigationBar, titleTextField, contentTextView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleTextField.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 20),
            titleTextField.bottomAnchor.constraint(equalTo: contentTextView.topAnchor, constant: -20),
            
            contentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
