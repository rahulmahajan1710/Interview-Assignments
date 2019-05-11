//
//  DetailViewController.swift
//  DeskAssignment
//
//  Created by Rahul Mahajan on 30/03/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var userDetailViewModel = UserDetailViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        userDetailViewModel.setupData()
        navigationItem.title = "User Details"
    }
    

    @IBAction func backButtonTaped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    

}


extension DetailViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDetailViewModel.userData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.userDetailCellIdentifier, for: indexPath)
        let field = userDetailViewModel.userData[indexPath.row]
        cell.textLabel?.text = field.name
        cell.detailTextLabel?.textColor = UIColor.gray
        cell.detailTextLabel?.text = field.value as? String
        return cell
    }
}
