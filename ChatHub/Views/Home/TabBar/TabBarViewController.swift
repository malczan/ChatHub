//
//  TabBarViewController.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 03/02/2023.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().backgroundColor = UIColor(named: "backgroundColor")
        UITabBar.appearance().tintColor = UIColor(named: "purple")
        

        self.tabBar.isTranslucent = true
        
        
        let messegesViewController = MessegesViewController()
        let friendsViewController = FriendsViewController()
        let settingsViewController = SettingsViewController()
        
        messegesViewController.tabBarItem = UITabBarItem(
            title: "Messeges",
            image: UIImage(systemName: "message"),
            tag: 0)
        
        friendsViewController.tabBarItem = UITabBarItem(
            title: "Friends",
            image: UIImage(systemName: "person.2"),
            tag: 1)
        
        settingsViewController.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gear"),
            tag: 2)
        
        setViewControllers([messegesViewController, friendsViewController, settingsViewController], animated: false)
    }
    
    
    


}
