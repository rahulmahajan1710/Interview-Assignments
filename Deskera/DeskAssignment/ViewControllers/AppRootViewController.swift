//
//  AppRootViewController.swift
//  DeskAssignment
//
//  Created by Rahul Mahajan on 28/03/19.
//  Copyright © 2019 Rahul Mahajan. All rights reserved.
//

import UIKit

class AppRootViewController: UIViewController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        self.title = viewController.title
        if let vc = viewController as? ProfileViewController{
            navigationController?.isNavigationBarHidden = true
        }
        if let vc = viewController as? TableViewController{
            navigationController?.isNavigationBarHidden = true
        }
        else{
            navigationController?.isNavigationBarHidden = false
        }

    }
    

}
