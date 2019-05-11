//
//  TableViewController.swift
//  DeskAssignment
//
//  Created by Rahul Mahajan on 29/03/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    var datasource = ["Grapes","Banana","Pineapple","Coconut","Cranberry","Pear","Plum","Pomegranate","Peach","Soursop","Passionfruit","Jackfruit","Cloudberry"]
    var filteredData = [String]()
    var isSearching = Bool()

    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var itemTableView: UITableView!
    @IBOutlet weak var addNewItemButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDatasource()
    }

    func setupDatasource(){
        datasource = ["Grapes","Banana","Pineapple","Coconut","Cranberry","Pear","Plum","Pomegranate","Peach","Soursop","Passionfruit","Jackfruit","Cloudberry"]
        filteredData = datasource
    }

    func searchWith(text: String ) {
        if !text.isEmpty{
            isSearching = true
            let filteredArray = datasource.filter() { $0.contains(text) }
            filteredData = filteredArray.sorted()
        }
        else{
            isSearching = false
            filteredData = datasource
        }
        itemTableView.reloadData()
    }


    @IBAction func editButtonTapped(_ sender: Any) {
        if isSearching {
            searchBar.text = ""
            filteredData = datasource
            itemTableView.reloadData()
        }

        if itemTableView.isEditing {
            addNewItemButton.tag = 0
           addNewItemButton.setTitle("+", for: .normal)
           addNewItemButton.titleLabel?.font =  .systemFont(ofSize: 40)

           titleLabel.text = "Table"
           editButton.setTitle("Edit", for: .normal)
           itemTableView.setEditing(false, animated: true)

        }
        else {
            addNewItemButton.tag = 1
            addNewItemButton.setTitle("Delete", for: .normal)
            addNewItemButton.titleLabel?.font =  .systemFont(ofSize: 17)

            editButton.setTitle("Done", for: .normal)
            itemTableView.setEditing(true, animated: true)
            itemTableView.allowsSelectionDuringEditing = true
            itemTableView.allowsMultipleSelectionDuringEditing = true
            itemTableView.reloadData()
        }
    }

    @IBAction func addNewItemTouchUpInside(_ sender: UIButton) {
        if sender.tag == 0 {
            let alert = UIAlertController(title: "Add item to list", message: "Enter a title", preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.placeholder = "Title"
            }

            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in

                self.searchBar.text = ""
                let textField = alert!.textFields![0]

                if textField.text?.count ?? 0 > 0 {
                    self.datasource.append(textField.text!)
                    self.filteredData = self.datasource
                    DispatchQueue.main.async {
                        self.itemTableView.reloadData()
                    }
                }

            }))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            if let selectedRows = self.itemTableView.indexPathsForSelectedRows {
                var indexes = [Int]()
                for indexPath in selectedRows  {
                    indexes.append(indexPath.row)
                }
                datasource.remove(at: indexes)
                filteredData = datasource
                itemTableView.reloadData()
            }
        }
    }
}


extension TableViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = filteredData[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if tableView.isEditing {
            if let selectedRows = self.itemTableView.indexPathsForSelectedRows {
                self.titleLabel.text = "\(selectedRows.count) Selected"
            }
            return
        }

        let itemName = filteredData[indexPath.row];
        let alert = UIAlertController(title: "Edit/Save", message: "Update a title", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = itemName
        }

        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak alert] (_) in

            let textField = alert!.textFields![0]

            if textField.text?.count ?? 0 > 0 {

                if self.isSearching {
                    self.filteredData[indexPath.row] = textField.text!
                    if let itemIndexFromMainArray = self.datasource.index(where: {$0 == itemName}) {
                        self.datasource[itemIndexFromMainArray] = textField.text!;
                    }
                }
                else
                {
                    self.datasource[indexPath.row] = textField.text!
                    self.filteredData = self.datasource
                }

                DispatchQueue.main.async {
                    self.itemTableView.reloadData()
                }
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            if let selectedRows = self.itemTableView.indexPathsForSelectedRows {
                self.titleLabel.text = "\(selectedRows.count) Selected"
            }
            else
            {
                self.titleLabel.text = "Table"
            }
        }
    }

    //MARK: - Searchbar delegate methods
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.editButton.isHidden = true
        self.addNewItemButton.isHidden = true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      searchWith(text: searchText)
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        editButton.isHidden = false
        addNewItemButton.isHidden = false
        searchWith(text: searchBar.text ?? "")
        view.endEditing(true)
    }
}



