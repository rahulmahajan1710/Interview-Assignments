//
//  SettingViewController.swift
//  DeskAssignment
//
//  Created by Rahul Mahajan on 29/03/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateViewHeightConstriant: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    
    var settingViewModel = SettingViewModel()
    var isDatePickerShown = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Settings"
        toggleDatePicker()
        reloadTabelView()
    }
    func reloadTabelView(){
        settingViewModel.setup()
        tableView.reloadData()
    }

    @IBAction func dateSectionTapped(_ sender: UIButton) {
        let date = datePicker.date
        Global.shared.setUserInfo(key: Constants.probationends, value: date)
        toggleDatePicker()
        reloadTabelView()
    }
    
    func toggleDatePicker(){
        UIView.animate(withDuration: 0.2) {
            if self.isDatePickerShown{
                self.dateViewHeightConstriant.constant = 0.0
            }
            else{
                self.dateViewHeightConstriant.constant = 256.0
            }
             self.isDatePickerShown = !self.isDatePickerShown
        }
        
    }

}

extension SettingViewController : UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingViewModel.settingData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingViewModel.settingData[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = settingViewModel.settingData[indexPath.section]
        let field = data[indexPath.row]
        
        if let boolValue = field.value as? Bool{
            let switchCell = tableView.dequeueReusableCell(withIdentifier: "SwitchTableViewCell", for: indexPath) as! SwitchTableViewCell
            switchCell.titleLabel.text = field.name
            switchCell.switch.isOn = boolValue
            switchCell.switch.tag = (indexPath.section * 100) + indexPath.row
            switchCell.delegate = self
            return switchCell
        }
        else if let value = field.value as? String, value.isEmpty{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = field.name
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "rightDetail", for: indexPath)
        cell.textLabel?.text = field.name
        cell.detailTextLabel?.text = field.value as? String
        cell.detailTextLabel?.textColor = UIColor.gray
        return cell
    }

   

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = settingViewModel.settingData[indexPath.section]
        let field = data[indexPath.row]
        if field.name == Constants.viewDetailsTitle{
            if let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailNav") {
               present(detailVC, animated: true, completion: nil
                )
            }
        }
        else if field.name == Constants.temperatureTitle{
            let alertController = UIAlertController(title: Constants.selectTemperatureTitle, message: nil, preferredStyle: .actionSheet)
            let fahAction = UIAlertAction(title: Constants.fahreniet, style: .default) { (action) in
                field.value =  Constants.fahreniet
                Global.shared.setUserInfo(key: Constants.temperature, value: Constants.fahreniet)
                tableView.reloadData()
            }
            let celAction = UIAlertAction(title: Constants.celsius, style: .default) { (action) in
                field.value = Constants.celsius
                Global.shared.setUserInfo(key: Constants.temperature, value: Constants.celsius)
                tableView.reloadData()
            }
            alertController.addAction(fahAction)
            alertController.addAction(celAction)
            present(alertController, animated: true, completion: nil)
        }
        else if field.name == Constants.probationendsTitle{
            toggleDatePicker()
        }

    }

}


extension SettingViewController : SwitchTableCellDelegate{
    func switchTappedOnCell(cell: SwitchTableViewCell) {
        let tag = cell.switch.tag
        
        if tag >= 100 {
            let section : Int = tag/100
            let row  : Int = tag%100
           let field = settingViewModel.settingData[section][row]
            if let id = field.id {
                Global.shared.setUserInfo(key: id, value: cell.switch.isOn)
            }
        }
        else{
            let  field = settingViewModel.settingData[0][tag]
            if let id = field.id {
                Global.shared.setUserInfo(key: id, value: cell.switch.isOn)
            }
        }
        
    }
}
