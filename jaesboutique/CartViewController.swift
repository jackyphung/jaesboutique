//
//  CartViewController.swift
//  jaesboutique
//
//  Created by Jacky Phung on 2019-03-28.
//  Copyright © 2019 Jacky Phung. All rights reserved.
//
//  Jacky Phung 100801047
//  Jarone Rodney 101077225
//  Charles Santiago 101084441
//  Jullian Sy-Lucero 100998164

import UIKit
import SQLite3

class CartViewController: UITableViewController {
    var db:OpaquePointer?
    @IBOutlet weak var subtotalText: UILabel!
    @IBOutlet weak var taxText: UILabel!
    @IBOutlet weak var totalText: UILabel!
    
    var items = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let file = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("itemdatabase.db")
        
        if sqlite3_open(file.path, &db) != SQLITE_OK{
            print("error opening database")
        }
        
        readValues()
        subtotalText.text = "$\(subtotal())"
        taxText.text = "$\(tax())"
        totalText.text = "$\(total())"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        readValues()
        subtotalText.text = String(format: "$%.2f", subtotal())
        taxText.text = String(format: "$%.2f", tax())
        totalText.text = String(format: "$%.2f", total())
        tableView.reloadData()
    }
    
    func subtotal() -> Double {
        var sum:Double = 0
        for i in items {
            sum += i.price
        }
        let finalSum = (sum*100).rounded()/100
        return finalSum
    }
    
    func tax() -> Double {
        let tax = ((subtotal() * 0.13)*100).rounded()/100
        return tax
    }
    
    func total() -> Double {
        return ((subtotal() + tax())*100).rounded()/100
    }
    
    func readValues(){
        items.removeAll()
        let q = "SELECT * FROM Items WHERE cart = 1"
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
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = items[indexPath.row].name
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
            let dc = segue.destination as! CartDetailController
            dc.item = items[tableView.indexPathForSelectedRow!.row]
            dc.db = db
        }
    }


}
