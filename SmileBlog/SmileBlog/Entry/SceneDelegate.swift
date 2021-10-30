//
//  SceneDelegate.swift
//  SmileBlog
//
//  Created by WANKI KIM on 2021/10/30.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        
        let mainViewController = MainViewController()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        window?.backgroundColor = .white
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

