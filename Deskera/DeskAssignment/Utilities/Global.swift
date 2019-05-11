//
//  Global.swift
//  DeskAssignment
//
//  Created by Rahul Mahajan on 28/03/19.
//  Copyright © 2019 Rahul Mahajan. All rights reserved.
//

import Foundation

class Global {
    static let shared = Global()
    var fruits = [Fruit]()
    var user = User()
    
    private init(){

    }
    

    func setupData(){
        user.username = userDefaultStringForKey(key: Constants.username)
        user.email = userDefaultStringForKey(key: Constants.email)
        user.doj = userDefaultDateForKey(key: Constants.doj)
        user.hobby = userDefaultStringForKey(key: Constants.hobby)
        user.temperatureUnit = userDefaultStringForKey(key: Constants.temperature)
        user.isSoundAllowed = userDefaultBoolForKey(key: Constants.sound)
        user.isNotificationAllowed = userDefaultBoolForKey(key: Constants.notification)
        user.dateProbationEnds = userDefaultDateForKey(key: Constants.probationends)
        user.probationDuration = userDefaultIntForKey(key: Constants.probationDuration)
        user.permanentDate = userDefaultDateForKey(key: Constants.permanentDate)
        user.probationLength = userDefaultIntForKey(key: Constants.probationLength)
        setupFruits()
    }
    
    func setUserInfo(key: String, value : Any){
        UserDefaults.standard.setValue(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func setUserDefault(value : Any?, key : String)  {
       UserDefaults.standard.setValue(value, forKey: key)
    }
    
    func userDefaultStringForKey(key: String) -> String?{
        return UserDefaults.standard.string(forKey:key)
    }
    
    func userDefaultIntForKey(key : String) -> Int?{
        return UserDefaults.standard.integer(forKey: key)
    }
    
    func userDefaultBoolForKey(key : String) -> Bool? {
        return UserDefaults.standard.bool(forKey:key)
    }
    
    func userDefaultDateForKey(key: String) -> Date?{
       return UserDefaults.standard.value(forKey: key) as? Date
    }

    private func setupFruits() {
        if let filePath = Bundle.main.path(forResource: "fruits", ofType: "json"),
            let url = URL(string: "file://\(filePath)"){
            do {
                let  fileData = try  Data(contentsOf: url)
                if let json = try JSONSerialization.jsonObject(with: fileData, options: JSONSerialization.ReadingOptions.mutableLeaves) as? [String:Any],
                    let fruits = json["fruits"] as? [[String:String]]{
                    fillDatasource(fruits: fruits)
                }
            }
            catch let error{
                print("Error: \(error.localizedDescription)")
            }
        }
    }


    func fillDatasource(fruits : [[String: String]]){
        for info in fruits{
            if let name = info[Constants.name],
                let desc = info[Constants.description],
                let cat = info[Constants.category]{
                let fruit = Fruit(name: name, description: desc, category: cat)
                self.fruits.append(fruit)
            }
        }
    }
    
}
