//
//  MainTabBarController.swift
//  SmileBlog
//
//  Created by WANKI KIM on 2021/11/04.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private let mainViewController = MainViewController()
    private let newPostViewController = NewPostViewController()
    private let userSettingViewController = UserSettingViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationTapBar()
    }
}

// MARK: View Hierirachy
extension MainTabBarController {
    func configurationTapBar() {
        let mainNavigationController = UINavigationController(rootViewController: mainViewController)
        let userSettingNavigationController = UINavigationController(rootViewController: userSettingViewController)
        
        self.viewControllers = [mainNavigationController,
                                newPostViewController,
                                userSettingNavigationController]
        
        let mainTabBarItem = UITabBarItem(title: "홈",
                                           image: UIImage(systemName: "house.fill"),
                                           tag: 0)
        let newPostTabBarItem = UITabBarItem(title: "글 작성",
                                           image: UIImage(systemName: "note.text.badge.plus"),
                                           tag: 1)
        let userSettingTabBarItem = UITabBarItem(title: "사용자 설정",
                                            image: UIImage(systemName: "person.fill"),
                                            tag: 2)
        mainTabBarItem.standardAppearance?.selectionIndicatorTintColor = .red
        mainNavigationController.tabBarItem = mainTabBarItem
        newPostViewController.tabBarItem = newPostTabBarItem
        userSettingNavigationController.tabBarItem = userSettingTabBarItem
        
        self.delegate = self
        self.tabBar.selectedItem?.badgeColor = .gray
    }

}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is NewPostViewController {
            let nextVC = NewPostViewController()
            nextVC.modalPresentationStyle = .fullScreen
            nextVC.delegate = self.mainViewController
            tabBarController.modalPresentationStyle = .fullScreen
            tabBarController.present(nextVC, animated: true, completion: nil)
            return false
        }
        return true
    }
}
