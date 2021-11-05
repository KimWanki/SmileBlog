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
    private var postList: [Post] = []
    private var section: [String] = ["최신 포스트"]
    
    private var headerHeightConstraint: NSLayoutConstraint?
    private var navigationHeightWithStatusBarHeight: CGFloat = Header.defaultHeight
    
    private lazy var subTitleLabel = { return UILabel(frame: .zero) }()
    private lazy var mainHeaderView: MainHeaderView = {
        return MainHeaderView(frame: .zero)
    }()
    
    private lazy var postTableView: UITableView = {
        return UITableView.init(frame: .zero)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FMDBManager.shared.copyDatabaseIfNeeds()
        applyViewSettings()
        self.postList = FMDBManager.shared.getPosts()
    }
}

// MARK: - ViewConfiguration
extension MainViewController: ViewConfiguration {
    func applyViewSettings() {
        buildHierarchy()
        setupConstraints()
        configureViews()
        setupNavigationBar()
        setupTableView()
    }
    
    func buildHierarchy() {
        view.addSubviews(mainHeaderView, postTableView, subTitleLabel)
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
            
            postTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            postTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        let tableViewInset = UIEdgeInsets(top: height, left: 0, bottom: 0, right: 0)
        postTableView.contentInset = tableViewInset
    }
    
    func configureViews() {
        view.bringSubviewToFront(mainHeaderView)
        view.clipsToBounds = true
        subTitleLabel.text = "Life is Fruity. 인생 후르츠"
        subTitleLabel.font = .preferredFont(forTextStyle: .title3)
        subTitleLabel.font = .boldSystemFont(ofSize: 20)
        subTitleLabel.adjustsFontSizeToFitWidth = true
        subTitleLabel.textColor = .white
        
        postTableView.dataSource = self
        postTableView.delegate = self
    }
    
    func setupNavigationBar() {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        guard let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height
        else { return }
        guard let navigationBarHeight = self.navigationController?.navigationBar.frame.height
        else { return }
        
        navigationHeightWithStatusBarHeight = navigationBarHeight + statusBarHeight
        
        self.navigationItem.title = "루얀의 애플🍏 공간"
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .white
        
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
        
        navigationItem.leftBarButtonItem = settingButton
        navigationItem.rightBarButtonItems = [menuButton, searchButton]
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
    }

    func setupTableView() {
        postTableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseIdentifier)
        postTableView.register(IntroduceCell.self, forCellReuseIdentifier: IntroduceCell.reuseIdentifier)
        
        let offset: CGPoint = CGPoint(x: 0, y: -Header.defaultHeight-Constant.titleInset)
        self.postTableView.setContentOffset(offset, animated: false)
    }
}

// MARK: - Event
extension MainViewController {
    @objc
    func clickNewPostButton() {
        let newPostViewController = NewPostViewController()
        newPostViewController.view.backgroundColor = .white
        newPostViewController.modalPresentationStyle = .fullScreen
        
        newPostViewController.delegate = self
        self.present(newPostViewController, animated: true, completion: nil)
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
        default: return postList.count
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
            
            cell.configure(postList[indexPath.row])
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != .zero {
            let detailViewController = DetailViewController()
            detailViewController.delegate = self
            detailViewController.configure(postList[indexPath.row])
            self.navigationController?.navigationBar.isTranslucent = false
            self.tabBarController?.tabBar.isHidden = true
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}

extension MainViewController: PostReloadable {
    func reloadTableView(_ newPost: [Post]) {
        self.postList = newPost
        self.navigationController?.navigationBar.isTranslucent = true
        DispatchQueue.main.async {
            self.postTableView.reloadData()
        }
    }
}

extension MainViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        guard let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height
        else { return }
        
        let height = statusBarHeight + Header.defaultHeight
        guard scrollView.contentOffset.y < 0 else {
            postTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0 )
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
            postTableView.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0 )
            
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
