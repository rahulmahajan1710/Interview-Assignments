//
//  Fruit.swift
//  DeskAssignment
//
//  Created by Rahul Mahajan on 29/03/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation

class Fruit {
    let name : String
    let description : String
    let category : String
    var isFavorite = false
    init(name : String, description : String, category : String) {
        self.name = name
        self.description = description
        self.category = category
    }
}
