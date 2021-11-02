//
//  ViewController.swift
//  SmileBlog
//
//  Created by WANKI KIM on 2021/10/30.
//

import UIKit

final class MainViewController: UIViewController {
    enum Header {
        static let defaultHeight: CGFloat = 200
    }
    enum Constant {
        static let titleInset: CGFloat = 20
    }
    enum BasicInfo {
        static let title = "Life is Fruity. 인생 후르츠"
        static let desc = "블로그 소개 - 人生フルーツ  Life is Fruity"
    }
    
    private var section: [String] = ["최신 포스트", "전체 포스트"]
    
    private var headerHeightConstraint: NSLayoutConstraint?
    private var navigationHeightWithStatusBarHeight: CGFloat = Header.defaultHeight
    
    private lazy var subTitleLabel = { return UILabel(frame: .zero) }()
    private lazy var mainHeaderView: MainHeaderView = {
        return MainHeaderView(frame: .zero)
    }()
    
    private lazy var tableView: UITableView = {
        return UITableView.init(frame: .zero)
    }()
    
//    private var toolBar: UIToolbar = {
//        let toolBarView = UIToolbar()
//
//        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
//        let addPostButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: nil)
//        toolBarView.setItems([flexibleSpace, addPostButton, flexibleSpace], animated: false)
//
//        return toolBarView
//    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        applyViewSettings()
        self.navigationController?.setToolbarHidden(false, animated: false)
    }
}

// MARK: - ViewConfiguration
extension MainViewController: ViewConfiguration {
    func applyViewSettings() {
        buildHierarchy()
        setupConstraints()
        configureViews()
        setupNavigationBar()
        setupToolBar()
        setupTableView()
    }
    
    func buildHierarchy() {
        view.addSubviews(mainHeaderView, tableView, subTitleLabel)
        mainHeaderView.insertSubview(subTitleLabel, aboveSubview: mainHeaderView)
    }
    
    func setupConstraints() {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        guard let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height
        else { return }
        
        let height = statusBarHeight + Header.defaultHeight
        headerHeightConstraint =  mainHeaderView.heightAnchor.constraint(equalToConstant: navigationHeightWithStatusBarHeight)
        headerHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            mainHeaderView.topAnchor.constraint(equalTo: view.topAnchor),
            mainHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            subTitleLabel.leadingAnchor.constraint(equalTo: mainHeaderView.leadingAnchor,
                                                   constant: Constant.titleInset),
            subTitleLabel.trailingAnchor.constraint(equalTo: mainHeaderView.trailingAnchor,
                                                    constant: -Constant.titleInset),
            subTitleLabel.bottomAnchor.constraint(equalTo: mainHeaderView.bottomAnchor,
                                                  constant: -Constant.titleInset),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        let tableViewInset = UIEdgeInsets(top: height, left: 0, bottom: 0, right: 0)
        tableView.contentInset = tableViewInset
    }
    
    func configureViews() {
        view.bringSubviewToFront(mainHeaderView)
        
        subTitleLabel.text = "Life is Fruity. 인생 후르츠"
        subTitleLabel.font = .preferredFont(forTextStyle: .title3)
        subTitleLabel.font = .boldSystemFont(ofSize: 20)
        subTitleLabel.adjustsFontSizeToFitWidth = true
        subTitleLabel.textColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupNavigationBar() {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        guard let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height
        else { return }
        guard let navigationBarHeight = self.navigationController?.navigationBar.frame.height
        else { return }
        
        navigationHeightWithStatusBarHeight = navigationBarHeight + statusBarHeight
        
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.isTranslucent = true
        
        navigationItem.title = "루얀의 애플🍏 공간"
        navigationController?.navigationBar.tintColor = .white
        
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"),
                                           style: .plain,
                                           target: nil,
                                           action: nil)
        let menuButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"),
                                         style: .plain,
                                         target: nil,
                                         action: nil)
        let settingButton = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"),
                                            style: .plain,
                                            target: nil,
                                            action: nil)
        
        searchButton.tintColor = .darkGray
        settingButton.tintColor = .darkGray
        menuButton.tintColor = .darkGray
        
        navigationItem.leftBarButtonItem = settingButton
        navigationItem.rightBarButtonItems = [menuButton, searchButton]
        
        self.navigationController?.navigationBar.tintColor = .black
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    func setupToolBar() {
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let addPostButton = UIBarButtonItem(image: UIImage(systemName: "note.text.badge.plus"), style: .plain, target: self, action: nil)
        
        addPostButton.tintColor = .gray
        
        toolbarItems = [flexibleSpace, addPostButton, flexibleSpace]
    }
    
    func setupTableView() {
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseIdentifier)
        tableView.register(IntroduceCell.self, forCellReuseIdentifier: IntroduceCell.reuseIdentifier)
    }
}

// MARK: - UITableViewDataSource, UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return section.count+1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        default: return 10
        }
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = IntroduceCell()
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: MainTableViewCell.reuseIdentifier
            ) as? MainTableViewCell
            else { fatalError() }
        
            cell.configure(Post(title: "test", content: "test", date: "test", comments: 5))
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == .zero {
            return BasicInfo.desc
        } else {
            return self.section[section-1]
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

extension MainViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        guard let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height
        else { return }
        
        let height = statusBarHeight + Header.defaultHeight
        guard scrollView.contentOffset.y < 0 else {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0 )
            headerHeightConstraint.flatMap {
                if $0.constant > .zero {
                    $0.constant = .zero
                    self.mainHeaderView.alpha = 0
                }
            }
            return
        }
        
        guard scrollView.contentOffset.y <= -height else {
            let topInset = abs(scrollView.contentOffset.y)
            tableView.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0 )
            
            headerHeightConstraint.flatMap {
                $0.constant = topInset + navigationHeightWithStatusBarHeight
            }
            self.mainHeaderView.alpha = topInset  / height + 0.2
            
            self.view.layoutIfNeeded()
            return
        }
        
        let insetTop = abs(scrollView.contentOffset.y)
        headerHeightConstraint
            .flatMap { $0.constant = insetTop + navigationHeightWithStatusBarHeight }
    }
}
