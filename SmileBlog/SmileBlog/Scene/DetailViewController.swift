//
//  DetailViewController.swift
//  SmileBlog
//
//  Created by WANKI KIM on 2021/11/03.
//

import UIKit

class DetailViewController: UIViewController {
    private var post: Post?
    private var inputViewBottomConstraint: NSLayoutConstraint?
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var contentView: UITextView = {
        let textView = UITextView(frame: .zero)
        return textView
    }()
    
    private var commentView: CommentField = {
        let commentView = CommentField(frame: .zero)
        commentView.backgroundColor = .yellow
        return commentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyViewSettings()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardShow),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc
    func keyboardShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            
            guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
            else { return }
            inputViewBottomConstraint?.constant = -keyboardHeight
            
            UIView.animate(withDuration: duration) {
                self.view.layoutIfNeeded()
            }

        }
    }

    @objc
    func keyboardHide(_ notification: Notification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
        else { return }
        
        inputViewBottomConstraint?.constant = .zero
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
        
        
    }
}

extension DetailViewController: ViewConfiguration {
    func buildHierarchy() {
        view.addSubviews(titleLabel, contentView, commentView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.topAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: commentView.topAnchor),
            
            commentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            commentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            commentView.heightAnchor.constraint(equalToConstant: 60)
        ])
        inputViewBottomConstraint = commentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        inputViewBottomConstraint?.isActive = true
    }
}

extension DetailViewController {
    func configure(_ post: Post) {
        self.post = post
        self.titleLabel.text = post.title
        self.contentView.text = post.content
    }
}
