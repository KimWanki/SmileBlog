//
//  MyPageViewController.swift
//  SmileBlog
//
//  Created by WANKI KIM on 2021/11/04.
//

import UIKit

final class MyPageViewController: UIViewController {
    private let optionList = ["내 정보 수정", "모드 변환", "피드백", "다크모크 설정"]
    private lazy var myPageTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyViewSettings()
    }
}

// MARK: - ViewConfiguraion
extension MyPageViewController: ViewConfiguration {
    func buildHierarchy() {
        view.addSubviews(myPageTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            myPageTableView.topAnchor.constraint(equalTo: view.topAnchor),
            myPageTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            myPageTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myPageTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func configureViews() {
        myPageTableView.dataSource = self
        myPageTableView.delegate = self
        myPageTableView.register(MyPageCell.self, forCellReuseIdentifier: MyPageCell.reuseIdentifier)
    }
}
// MARK: - UITableViewDataSource, UITableViewDelegate
extension MyPageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        optionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageCell.reuseIdentifier)
                as? MyPageCell
        else { fatalError() }
        
        cell.configure(optionList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return MyPageHeaderView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

