//
//  SceneDelegate.swift
//  FoodStore
//
//  Created by Артем Орлов on 03.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func mainFlow() -> TabBarController {
        let tabBarController = TabBarController()
        
        return tabBarController
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = mainFlow()
        window?.makeKeyAndVisible()
    }
}

