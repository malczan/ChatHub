//
//  TabBarCoordinator.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 03/02/2023.
//

import UIKit

final class TabBarCoordinator: Coordinator {
    
    private typealias TabBarFactory = TabBarViewControllerFactory
    private typealias SettingsFactory = SettingsViewControllerFactory
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let window: UIWindow

    
    init(navigationController: UINavigationController,
         window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
    }
    
    func start() {
        
        let tabBarViewController = TabBarFactory.createTabBarViewController()
        
        let messgesNavigationController = UINavigationController()
        messgesNavigationController.tabBarItem = UITabBarItem(
            title: "Messeges",
            image: UIImage(systemName: "message"),
            tag: 0)
        let messegesCoordinator = MessegesViewCoordinator(navigationController: messgesNavigationController)
        messegesCoordinator.start()
        
        let friendsNavigationController = UINavigationController()
        friendsNavigationController.tabBarItem = UITabBarItem(
            title: "Friends",
            image: UIImage(systemName: "person.2"),
            tag: 1)
        let friendsCoordinator = FriendsViewCoordinator(navigationController: friendsNavigationController)
        friendsCoordinator.start()
        
        let settingsNavigationController = UINavigationController()
        settingsNavigationController.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gear"),
            tag: 2)
        let settingsCoordinator = SettingsViewCoordinator(navigationController: settingsNavigationController)
        settingsCoordinator.start()
        
        tabBarViewController.viewControllers = [messgesNavigationController, friendsNavigationController, settingsNavigationController]
        navigationController.setViewControllers([tabBarViewController], animated: true)
        
        
    }
    
    
}
