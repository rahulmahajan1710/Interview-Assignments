//
//  DataField.swift
//  DeskAssignment
//
//  Created by Rahul Mahajan on 28/03/19.
//  Copyright © 2019 Rahul Mahajan. All rights reserved.
//

import UIKit



class DataField {
    var name : String
    var value : Any?
    var placeholder : String
    var id : String?
    
    init(name : String, placeholder : String, value : Any? = nil, id : String? = nil) {
        self.name = name
        self.placeholder = placeholder
        self.value = value
        self.id = id
    }
}
