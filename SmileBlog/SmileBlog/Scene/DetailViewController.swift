//
//  DetailViewController.swift
//  SmileBlog
//
//  Created by WANKI KIM on 2021/11/03.
//

import UIKit

class DetailViewController: UIViewController {
    private var post: Post?
    private var commentList: [Comment] = []
    private var inputViewBottomConstraint: NSLayoutConstraint?
    
    
    private lazy var contentTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(DetailViewContentCell.self, forCellReuseIdentifier: DetailViewContentCell.reuseIdentifier)
        tableView.register(DetailViewCommentCell.self, forCellReuseIdentifier: DetailViewCommentCell.reusableIdentifier)
        
        return tableView
    }()
    
    private var commentView: CommentField = {
        let commentView = CommentField(frame: .zero)
        commentView.backgroundColor = .yellow
        commentView.addButton.addTarget(self, action: #selector(clickDoneButton), for: .touchUpInside)
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
    
    @objc
    func clickDoneButton() {
        guard let postNumber = post?.number else { return }
        let createDate = DateFormatter.getCurrent()
        let comment = Comment(number: nil,
                              user: "동원",
                              post: postNumber,
                              content: self.commentView.commentTextField.text!,
                              date: createDate)

        if FMDBManager.shared.add(comment) {
            print("Saved")
        } else {
            print("Not Saved")
        }
        commentList = FMDBManager.shared.getComments(postNumber)
        DispatchQueue.main.async {
            self.contentTableView.reloadData()
        }
    }
}

extension DetailViewController: ViewConfiguration {
    func buildHierarchy() {
        view.addSubviews(contentTableView, commentView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentTableView.bottomAnchor.constraint(equalTo: commentView.topAnchor),
            
            commentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            commentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            commentView.heightAnchor.constraint(equalToConstant: 60)
        ])
        inputViewBottomConstraint = commentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        inputViewBottomConstraint?.isActive = true
    }
    
    func configureViews() {
        self.contentTableView.dataSource = self
        self.contentTableView.delegate = self
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
}

extension DetailViewController {
    func configure(_ post: Post) {
        self.post = post
        post.number
            .flatMap { self.commentList = FMDBManager.shared.getComments($0) }
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = DetailViewContentCell()
            
            post.flatMap { cell.configure($0) }
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailViewCommentCell.reusableIdentifier) as? DetailViewCommentCell
            else { fatalError() }
            cell.configure(commentList[indexPath.row-1])
            return cell
        }
    }
}
