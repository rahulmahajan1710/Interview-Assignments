//
//  MainTabViewController.swift
//  DeskAssignment
//
//  Created by Rahul Mahajan on 28/03/19.
//  Copyright © 2019 Rahul Mahajan. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }
    
    override func didMove(toParent parent: UIViewController?) {
        if let appRootVC = parent as? AppRootViewController{
            print("Parent is APRVC")
            self.delegate = appRootVC
        }
    }

}
