//
//  ProfileViewModel.swift
//  DeskAssignment
//
//  Created by Rahul Mahajan on 02/04/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation

class ProfileViewModel {
    let usernameField =  DataField(name: Constants.usernameTitle, placeholder: Constants.usernamePlaceholder, value: Global.shared.userDefaultStringForKey(key: Constants.username))
    var userData = [DataField]()
    
    func setup(){
        let email = DataField(name: Constants.emailTitle, placeholder: Constants.emailPlaceholder, value : Global.shared.userDefaultStringForKey(key: Constants.email))
        
        let hobby = DataField(name: Constants.hobbyTitle, placeholder: Constants.hobbyPlaceholder, value: Global.shared.userDefaultStringForKey(key: Constants.hobby))
        
        let dojField = DataField(name: Constants.dateOfJoiningTitle, placeholder: Constants.dojPlaceholder, value: nil)
        if let doj = Global.shared.userDefaultDateForKey(key: Constants.doj){
            dojField.value = Utility.stringFromDate(date: doj)
        }
        userData = [email,hobby,dojField]
    }
}
