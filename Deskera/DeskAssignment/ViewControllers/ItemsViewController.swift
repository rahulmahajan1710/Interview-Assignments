//
//  ItemsViewController.swift
//  DeskAssignment
//
//  Created by Rahul Mahajan on 28/03/19.
//  Copyright © 2019 Rahul Mahajan. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentView: UISegmentedControl!
    var datasource = [Fruit]()


    override func viewDidLoad() {
        super.viewDidLoad()
        datasource = Global.shared.fruits
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(ItemsViewController.rightSwipe))
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)

        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(ItemsViewController.leftSwipe))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }



    @objc func rightSwipe(){
        if segmentView.selectedSegmentIndex == 2{
            let filteredArray = Global.shared.fruits.filter() { $0.category.contains("Category A") }
            datasource = filteredArray
            tableView.reloadData()
            segmentView.selectedSegmentIndex = 1
        }
        else if segmentView.selectedSegmentIndex == 1{
            datasource = Global.shared.fruits
            tableView.reloadData()
            segmentView.selectedSegmentIndex = 0
        }
    }

    @objc func leftSwipe(){
        if segmentView.selectedSegmentIndex == 0{
            let filteredArray = Global.shared.fruits.filter() { $0.category.contains("Category A") }
            datasource = filteredArray
            tableView.reloadData()
            segmentView.selectedSegmentIndex = 1
        }
        else if segmentView.selectedSegmentIndex == 1{
            let filteredArray = Global.shared.fruits.filter() { $0.category.contains("Category B") }
            datasource = filteredArray
            tableView.reloadData()
            segmentView.selectedSegmentIndex = 2
        }
    }


    @IBAction func segmentButtonTapped(_ sender: UISegmentedControl) {

        if sender.selectedSegmentIndex == 0 {
            datasource = Global.shared.fruits
            tableView.reloadData()
        }
        else if sender.selectedSegmentIndex == 1 {
            let filteredArray = Global.shared.fruits.filter() { $0.category.contains("Category A") }
            datasource = filteredArray
            tableView.reloadData()
        }
        else{
            let filteredArray = Global.shared.fruits.filter() { $0.category.contains("Category B") }
            datasource = filteredArray
            tableView.reloadData()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ItemsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let itemCell  = tableView.dequeueReusableCell(withIdentifier: "ItemsTableViewCell", for: indexPath) as! ItemsTableViewCell

        let fruit = datasource[indexPath.row]
        itemCell.nameLabel.text = fruit.name
        itemCell.descriptionLabel.text = fruit.description
        itemCell.categoryLabel.text = fruit.category
        itemCell.favButton.isSelected = fruit.isFavorite
        return itemCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ItemsTableViewCell
        let fruit = datasource[indexPath.row]
        cell.favButton.isSelected = !fruit.isFavorite
        fruit.isFavorite = !fruit.isFavorite
    }
}
