//
//  User.swift
//  DeskAssignment
//
//  Created by Rahul Mahajan on 02/04/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation


class User : NSObject{
    var username : String?
    var email : String?
    var hobby : String?
    var doj : Date?
    var temperatureUnit : String?
    var isSoundAllowed : Bool?
    var isNotificationAllowed : Bool?
    var dateProbationEnds : Date?
    var probationDuration : Int? // value in days
    var permanentDate : Date?
    var probationLength :  Int? //value in months
}
