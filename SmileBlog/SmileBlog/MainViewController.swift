//
//  ViewController.swift
//  SmileBlog
//
//  Created by WANKI KIM on 2021/10/30.
//

import UIKit
import SwiftUI

class MainViewController: UIViewController {
    private lazy var tableView: UITableView = {
        return UITableView(frame: .zero)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyViewSettings()
        
    }
}

extension MainViewController: ViewConfiguration {
    func buildHierarchy() {
        view.addSubviews(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func configureViews() {
        tableView.dataSource = self
    }
    
//    let logo = UIImageView(image: UIImage)
    
    func setupNavigationBar() {
        let width = view.frame.width
        
        let titleView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: width, height: 50))
        navigationItem.titleView = titleView
        navigationItem.title = "루얀의 애플 공간"
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
