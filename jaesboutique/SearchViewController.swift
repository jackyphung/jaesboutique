//
//  SearchViewController.swift
//  jaesboutique
//
//  Created by Jacky Phung on 2019-04-03.
//  Copyright © 2019 Jacky Phung. All rights reserved.
//
//  Jacky Phung 100801047
//  Jarone Rodney 101077225
//  Charles Santiago 101084441
//  Jullian Sy-Lucero 100998164
//
// Found information on raywanderlich regarding the search controller by Tom Elliot https://www.raywenderlich.com/472-uisearchcontroller-tutorial-getting-started

import UIKit
import SQLite3

class SearchViewController: UITableViewController {
    var db: OpaquePointer?
    
    // Creating a search controller on this view
    let searchController = UISearchController(searchResultsController: nil)
    var items = [Item]()
    var filteredItems = [Item]()

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Categories"
        navigationItem.searchController = searchController
        definesPresentationContext = true


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let file = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("itemdatabase.db")
        
        if sqlite3_open(file.path, &db) != SQLITE_OK{
            print("error opening database")
        }
        
        readValues()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        readValues()
        tableView.reloadData()
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    // Filtering item by the item's category and storing it into a filtered array
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredItems = items.filter({(item: Item) -> Bool in
            return item.category.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func readValues(){
        items.removeAll()
        let q = "SELECT * FROM Items"
        var stmt:OpaquePointer?
        
        if sqlite3_prepare(db, q, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        while sqlite3_step(stmt) == SQLITE_ROW {
            let id = Int(sqlite3_column_int(stmt, 0))
            let brand = String(cString: sqlite3_column_text(stmt, 1))
            let type = String(cString: sqlite3_column_text(stmt, 2))
            let name = String(cString: sqlite3_column_text(stmt, 3))
            let category = String(cString: sqlite3_column_text(stmt, 4))
            let price = Double(sqlite3_column_double(stmt, 5))
            let i = Item(id: id, brand: brand, type: type, name: name, category: category,price: price)
            items.append(i)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isFiltering(){
            return filteredItems.count
        }
        
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        let item: Item
        if isFiltering() {
            item = filteredItems[indexPath.row]
        }
        else {
            item = items[indexPath.row]
        }
        // Configure the cell...
        //cell.textLabel?.text = items[indexPath.row].type
        cell.textLabel?.text = item.name
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show" {
            let dc = segue.destination as! ItemDetail
            if filteredItems.count == 0 {
                dc.item = items[tableView.indexPathForSelectedRow!.row]
            }
            else {
                dc.item = filteredItems[tableView.indexPathForSelectedRow!.row]
            }
            dc.db = db
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
