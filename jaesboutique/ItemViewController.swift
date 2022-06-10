//
//  ItemViewController.swift
//  jaesboutique
//
//  Created by Jacky Phung on 2019-03-19.
//  Copyright © 2019 Jacky Phung. All rights reserved.
// Jacky Phung 100801047
// Jarone Rodney 101077225
// Charles Santiago 101084441
// Jullian Sy-Lucero 100998164

import UIKit
import SQLite3

class ItemViewController: UITableViewController {
    var db:OpaquePointer?
    var items = [Item]()
    let SQLITE_TRANSIENT = unsafeBitCast(OpaquePointer(bitPattern: -1), to: sqlite3_destructor_type.self)
    
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
        else{
            let create = "CREATE TABLE IF NOT EXISTS Items (id INTEGER PRIMARY KEY AUTOINCREMENT, brand TEXT, type TEXT, name TEXT, category TEXT, price REAL, cart NUMERIC)"
            if sqlite3_exec(db, create, nil, nil, nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(db))
                print("error creating db: \(err)")
            }
            
            let query = "SELECT * FROM Items"
            var stmt:OpaquePointer?
        }
        readValues()
        if items.count == 0 {
            addData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        readValues()
        tableView.reloadData()
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
    
    func addData() {
        gucciTShirt()
        offwhiteTShirt()
        jeans()
        shirt()
        jacket()
        shoes()
        watch()
    }
    
    func gucciTShirt() {
        let insert = "INSERT INTO Items(brand, type, name, category, price, cart) VALUES(?, ?, ?, 'Default', ?, 0)"
        var stmt:OpaquePointer?
        

        if sqlite3_prepare(db, insert, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
            
        if sqlite3_bind_text(stmt, 1, "Gucci", -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        
        if sqlite3_bind_text(stmt, 2, "T-Shirt", -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        
        if sqlite3_bind_text(stmt, 3, "Classic Black Logo Tee", -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        
        if sqlite3_bind_double(stmt, 4, 49.99) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error biding price: \(err)")
            return
        }
            
        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(db))
            print("error executing insert: \(err)")
            return
        }
    }
    
    func offwhiteTShirt() {
        let insert = "INSERT INTO Items(brand, type, name, category, price, cart) VALUES(?, ?, ?, 'Default', ?, 0)"
        var stmt:OpaquePointer?
        
        
        if sqlite3_prepare(db, insert, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        
        if sqlite3_bind_text(stmt, 1, "Off-White", -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        
        if sqlite3_bind_text(stmt, 2, "T-Shirt", -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        
        if sqlite3_bind_text(stmt, 3, "Cross Diagonal Toronto Shirt", -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        
        if sqlite3_bind_double(stmt, 4, 59.99) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error biding price: \(err)")
            return
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(db))
            print("error executing insert: \(err)")
            return
        }
    }
    
    func jeans() {
        let insert = "INSERT INTO Items(brand, type, name, category, price, cart) VALUES(?, ?, ?, 'Default', ?, 0)"
        var stmt:OpaquePointer?
        
        
        if sqlite3_prepare(db, insert, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        
        if sqlite3_bind_text(stmt, 1, "Nudie Jeans", -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        
        if sqlite3_bind_text(stmt, 2, "Jeans", -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        
        if sqlite3_bind_text(stmt, 3, "Indigo Raw Denim 16oz", -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        
        if sqlite3_bind_double(stmt, 4, 129.99) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error biding price: \(err)")
            return
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(db))
            print("error executing insert: \(err)")
            return
        }
    }
    
    func jacket() {
        let insert = "INSERT INTO Items(brand, type, name, category, price, cart) VALUES(?, ?, ?, 'Default', ?, 0)"
        var stmt:OpaquePointer?
        
        
        if sqlite3_prepare(db, insert, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        
        if sqlite3_bind_text(stmt, 1, "Levi", -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        
        if sqlite3_bind_text(stmt, 2, "Jacket", -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        
        if sqlite3_bind_text(stmt, 3, "Blue Denim Trucker Jacket", -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        
        if sqlite3_bind_double(stmt, 4, 109.99) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error biding price: \(err)")
            return
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(db))
            print("error executing insert: \(err)")
            return
        }
    }
    
    func shirt() {
        let insert = "INSERT INTO Items(brand, type, name, category, price, cart) VALUES(?, ?, ?, 'Default', ?, 0)"
        var stmt:OpaquePointer?
        
        
        if sqlite3_prepare(db, insert, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        
        if sqlite3_bind_text(stmt, 1, "Gucci", -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        
        if sqlite3_bind_text(stmt, 2, "Shirt", -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        
        if sqlite3_bind_text(stmt, 3, "White Button Up Shirt With Embroidered Logo", -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        
        if sqlite3_bind_double(stmt, 4, 79.99) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error biding price: \(err)")
            return
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(db))
            print("error executing insert: \(err)")
            return
        }
    }
    
    func shoes() {
        let insert = "INSERT INTO Items(brand, type, name, category, price, cart) VALUES(?, ?, ?, 'Default', ?, 0)"
        var stmt:OpaquePointer?
        
        
        if sqlite3_prepare(db, insert, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        
        if sqlite3_bind_text(stmt, 1, "Nike", -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        
        if sqlite3_bind_text(stmt, 2, "Shoes", -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        
        if sqlite3_bind_text(stmt, 3, "Acronym x Nike Presto Yellow Racers", -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        
        if sqlite3_bind_double(stmt, 4, 209.99) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error biding price: \(err)")
            return
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(db))
            print("error executing insert: \(err)")
            return
        }
    }
    
    func watch() {
        let insert = "INSERT INTO Items(brand, type, name, category, price, cart) VALUES(?, ?, ?, 'Default', ?, 0)"
        var stmt:OpaquePointer?
        
        
        if sqlite3_prepare(db, insert, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        
        if sqlite3_bind_text(stmt, 1, "IWC", -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        
        if sqlite3_bind_text(stmt, 2, "Watch", -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        
        if sqlite3_bind_text(stmt, 3, "Pilot's Watch Chronograph Edition - Le Petit Prince", -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        
        if sqlite3_bind_double(stmt, 4, 5960.99) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error biding price: \(err)")
            return
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(db))
            print("error executing insert: \(err)")
            return
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
            dc.item = items[tableView.indexPathForSelectedRow!.row]
            dc.db = db
        }
        else if segue.identifier == "add" {
            let dc = segue.destination as! AddItemController
            dc.db = db
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }


}
