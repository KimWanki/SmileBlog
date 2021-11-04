//
//  ModifyPostViewController.swift
//  SmileBlog
//
//  Created by WANKI KIM on 2021/11/04.
//

import UIKit

final class UpdatePostViewController: UIViewController {
    enum Constant {
        static let inset: CGFloat = 20
    }
    private var post: Post?
    weak var delegate: PostReloadable?
    
    private lazy var titleTextField: TitleTextField = {
        let textField = TitleTextField(frame: .zero)
        textField.placeholder = "제목"
        textField.font = .preferredFont(forTextStyle: .title3)
        return textField
    }()
    
    private lazy var contentTextView: UITextView = {
        let textView = UITextView()
        textView.text = "본문을 입력해보세요!"
        textView.font = .preferredFont(forTextStyle: .body)
        return textView
    }()
    
    private lazy var cancelButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(clickCancelButton))
        return barButton
    }()
    
    private lazy var finishButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(clickFinishButton))
        return barButton
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
}

// MARK: - User Event
extension UpdatePostViewController {
    @objc
    func keyboardShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardHeight, right: 0.0)
            contentTextView.contentInset = contentInsets
            contentTextView.verticalScrollIndicatorInsets = contentInsets
        }
    }
    
    @objc
    func keyboardHide(_ notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        contentTextView.contentInset = contentInsets
        contentTextView.verticalScrollIndicatorInsets = contentInsets
    }
    
    @objc
    func clickCancelButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func clickFinishButton() {
        guard let postNum = post?.number
        else { return }
        let newPost = Post(number: post?.number, title: titleTextField.text!, content: contentTextView.text, date: post!.date)
        if FMDBManager.shared.update(postNum: postNum,
                                     title: titleTextField.text!, content: contentTextView.text!) {
            self.delegate?.updatePost(newPost)
        }
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - TextView Delegate
extension UpdatePostViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .gray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "본문을 입력해보세요!"
            textView.textColor = .gray
        }
    }
}

// MARK: - ViewConfiguration
extension UpdatePostViewController: ViewConfiguration {
    func buildHierarchy() {
        view.addSubviews(titleTextField, contentTextView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.inset),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.inset),
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constant.inset),
            titleTextField.bottomAnchor.constraint(equalTo: contentTextView.topAnchor, constant: -Constant.inset),
            
            contentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.inset),
            contentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.inset),
            contentTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureViews() {
        view.backgroundColor = .white
        
        contentTextView.delegate = self
        
        self.titleTextField.text = post?.title
        self.contentTextView.text = post?.content
        
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.rightBarButtonItem = finishButton
    }
}

// MARK: - AlertController
extension UpdatePostViewController {
    func showInputRequestAlert() {
        let alertController = UIAlertController(
            title: "제목과 내용을 입력해주세요😭",
            message: "다시 작성하러 가볼까요?🤩",
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil)
        alertController.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension UpdatePostViewController {
    func configure(_ post: Post) {
        self.post = post
    }
}
