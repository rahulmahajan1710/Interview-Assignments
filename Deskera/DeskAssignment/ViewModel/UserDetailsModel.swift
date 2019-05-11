//
//  UserDetailsModel.swift
//  DeskAssignment
//
//  Created by Rahul Mahajan on 02/04/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation

class UserDetailViewModel {
    var userData = [DataField]()
    
    func setupData(){
        userData.removeAll()
        let username = DataField(name: Constants.usernameTitle, placeholder: "", value: Global.shared.userDefaultStringForKey(key: Constants.username))
        let email =  DataField(name: Constants.emailTitle, placeholder: "", value: Global.shared.userDefaultStringForKey(key: Constants.email))
     
        
        
        let temperature =  DataField(name: Constants.temperatureTitle, placeholder: "", value: Global.shared.userDefaultStringForKey(key: Constants.temperature) ?? Constants.fahreniet)
        let sound =   DataField(name: Constants.soundTitle, placeholder: "")
        if let soundValue = Global.shared.userDefaultBoolForKey(key: Constants.sound), soundValue{
            sound.value = "True"
        }else{
            sound.value = "False"
        }
        let notification =  DataField(name: Constants.notificationTitle, placeholder: "", value: Global.shared.userDefaultBoolForKey(key: Constants.notification))
       
        if let notificationValue = Global.shared.userDefaultBoolForKey(key: Constants.notification), notificationValue{
            notification.value = "True"
        }else{
            notification.value = "False"
        }
        
        
        let dojField = DataField(name: Constants.dateOfJoiningTitle, placeholder: Constants.dojPlaceholder, value: nil)
        if let doj = Global.shared.userDefaultDateForKey(key: Constants.doj){
            dojField.value = doj
        }
       
        
        let probationEndField = DataField(name: Constants.probationendsTitle, placeholder: Constants.NA)
        if let probationEnds = Global.shared.userDefaultDateForKey(key: Constants.probationends){
            probationEndField.value =  probationEnds
        }
        
        let probationDuration = DataField(name: Constants.probationDurationTitle, placeholder: "", value: Constants.NA)
        let permanentDateField = DataField(name: Constants.permanentDateTitle, placeholder: "", value: Constants.NA)
        let probationLength = DataField(name: Constants.probationLengthTitle, placeholder: "", value: Constants.NA)
        
        if let dojDate = dojField.value as? Date,
            let probEndDate = probationEndField.value as? Date{
            let calendar = Calendar.current
            let components = calendar.dateComponents([.day, .month], from: dojDate, to: probEndDate)
            probationDuration.value = "\(components.month ?? 0 ) month \(components.day ?? 0) days"
            if let permDate = Calendar.current.date(byAdding: .day, value: 1, to: probEndDate){
                permanentDateField.value = Utility.stringFromDate(date: permDate)
            }
            if components.month ?? 0 < 6 {
                probationLength.value = "Less than 6 months"
            }
            else{
                probationLength.value = "More than 6 months"
            }
            
            dojField.value = Utility.stringFromDate(date: dojDate)
            probationEndField.value = Utility.stringFromDate(date: probEndDate)
        }
        
        userData = [username,email,dojField,temperature,sound,notification,probationEndField,probationDuration,permanentDateField,probationLength]
        
    }
}
