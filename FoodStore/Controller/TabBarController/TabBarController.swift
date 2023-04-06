//
//  TabBarController.swift
//  FoodStore
//
//  Created by Артем Орлов on 06.04.2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let networkService = RecipeNetworkService()
        let presenter = RecipeListPresenter(networkService: networkService)
        let dishesVC = DishesViewController()
                tabBar.backgroundColor = .white
                tabBar.isTranslucent = false
        presenter.view = dishesVC
        dishesVC.presenter = presenter
        
        let contactVC = ConcactViewController()
        let profileVC = ProfileViewController()
        let basketVC = BasketViewController()
        tabBar.tintColor = UIColor(red: 0.99, green: 0.23, blue: 0.41, alpha: 1.0)
        dishesVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "menu"), tag: 0)
        contactVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "contact"), tag: 1)
        profileVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "profile"), tag: 2)
        basketVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "badge"), tag: 3)

        self.viewControllers = [dishesVC, contactVC, profileVC, basketVC]
    }
}
