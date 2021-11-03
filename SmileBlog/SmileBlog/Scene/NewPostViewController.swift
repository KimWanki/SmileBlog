//
//  NewPostViewController.swift
//  SmileBlog
//
//  Created by WANKI KIM on 2021/11/03.
//

import UIKit

protocol PostReloadable: NSObject {
    func reloadTableView(_ newPost: [Post])
}

class NewPostViewController: UIViewController {
    enum Constant {
        static let inset: CGFloat = 20
    }
    
    weak var delegate: PostReloadable?
    
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
        textView.font = .preferredFont(forTextStyle: .body)
        return textView
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
    func clickCancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func clickDoneButton() {
        guard titleTextField.text != nil && contentTextView.text != nil && contentTextView.textColor != .gray
        else {
            showInputRequestAlert()
            return
        }
        
        let createDate = DateFormatter.getCurrent()
        let post = Post(number: nil, title: titleTextField.text!, content: contentTextView.text, date: createDate)
        if FMDBManager.shared.add(post) {
            self.dismiss(animated: true) {
                let post = FMDBManager.shared.getPosts()
                self.delegate?.reloadTableView(post)
            }
        } else {
            
        }
        
    }

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
}

// MARK: - TextView Delegate
extension NewPostViewController: UITextViewDelegate {
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

extension NewPostViewController: ViewConfiguration {
    func buildHierarchy() {
        view.addSubviews(navigationBar, titleTextField, contentTextView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.inset),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.inset),
            titleTextField.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: Constant.inset),
            titleTextField.bottomAnchor.constraint(equalTo: contentTextView.topAnchor, constant: -Constant.inset),
            
            contentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.inset),
            contentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.inset),
            contentTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureViews() {
        contentTextView.delegate = self
        contentTextView.textColor = .gray
        contentTextView.text = "본문을 입력해보세요!"
        
    }
}

extension NewPostViewController {
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
