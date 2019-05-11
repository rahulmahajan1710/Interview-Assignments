//
//  FavouritesViewController.swift
//  DeskAssignment
//
//  Created by Rahul Mahajan on 29/03/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController {

    var datasource = [Fruit]()

    @IBOutlet weak var favTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         reloadTableView()
    }
    func reloadTableView() {
        let filteredArray = Global.shared.fruits.filter() { $0.isFavorite == true }
        datasource = filteredArray
        favTableView.reloadData()
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

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
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
        let fruit = datasource[indexPath.row]
        fruit.isFavorite = !fruit.isFavorite
        reloadTableView()
    }

}
