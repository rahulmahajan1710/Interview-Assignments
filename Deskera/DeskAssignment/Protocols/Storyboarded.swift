//
//  Storyboarded.swift
//  DeskAssignment
//
//  Created by Rahul Mahajan on 28/03/19.
//  Copyright © 2019 Rahul Mahajan. All rights reserved.
//

import Foundation

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self : UIViewController{
    static func instantiate() -> Self{
        let fullname = NSStringFromClass(self)
        let className = fullname.components(separatedBy: ".").last!
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
