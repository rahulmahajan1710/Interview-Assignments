//
//  Utility.swift
//  DeskAssignment
//
//  Created by Rahul Mahajan on 28/03/19.
//  Copyright © 2019 Rahul Mahajan. All rights reserved.
//

import Foundation
import UIKit

class  Utility: NSObject {
    
    
    static func circularView(view : UIView){
        view.layer.cornerRadius = view.frame.size.height / 2.0
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 1.0
        view.layer.shadowOpacity = 0.5
    }
    
    static func stringFromDate(date : Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-YYYY"
        return  dateFormatter.string(from: date)
    }
    
    static func dateFromString(string : String) -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-YYYY"
        return  dateFormatter.date(from: string)
    }
    

    
}


extension Array {
    mutating func remove(at indexes: [Int]) {
        var lastIndex: Int? = nil
        for index in indexes.sorted(by: >) {
            guard lastIndex != index else {
                continue
            }
            remove(at: index)
            lastIndex = index
        }
    }
}
