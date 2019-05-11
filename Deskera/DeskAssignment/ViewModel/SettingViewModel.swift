//
//  SettingViewModel.swift
//  DeskAssignment
//
//  Created by Rahul Mahajan on 02/04/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation

class SettingViewModel: NSObject {
    var settingData = [[DataField]]()
    
    func setup()  {
        settingData.removeAll()
        settingData.append(
            [DataField(name: Constants.temperatureTitle, placeholder: "", value: Global.shared.userDefaultStringForKey(key: Constants.temperature) ?? Constants.fahreniet, id : Constants.temperature),
             DataField(name: Constants.soundTitle, placeholder: "", value: Global.shared.userDefaultBoolForKey(key: Constants.sound) ?? false , id : Constants.sound)])
        
        let probationEndField = DataField(name: Constants.probationendsTitle, placeholder: Constants.NA, value: nil , id : Constants.probationends)
        if let probationEnds = Global.shared.userDefaultDateForKey(key: Constants.probationends){
            probationEndField.value =  Utility.stringFromDate(date: probationEnds)
        }
        else{
            probationEndField.value = Constants.NA

        }
        
        settingData.append([
            DataField(name: Constants.notificationTitle, placeholder: "", value: Global.shared.userDefaultBoolForKey(key: Constants.notification), id: Constants.notification),
            probationEndField
            ])
        settingData.append([
            DataField(name: Constants.viewDetailsTitle, placeholder: "", value: "")])
    }
}
