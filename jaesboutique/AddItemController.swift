//
//  AddItemController.swift
//  jaesboutique
//
//  Created by Jacky Phung on 2019-03-26.
//  Copyright © 2019 Jacky Phung. All rights reserved.
// Jacky Phung 100801047
// Jarone Rodney 101077225
// Charles Santiago 101084441
// Jullian Sy-Lucero 100998164

import UIKit
import SQLite3

class AddItemController: UIViewController {
    var db:OpaquePointer?
    @IBOutlet weak var brandText: UITextField!
    @IBOutlet weak var typeText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var categoryText: UITextField!
    @IBOutlet weak var priceText: UITextField!
    let SQLITE_TRANSIENT = unsafeBitCast(OpaquePointer(bitPattern: -1), to: sqlite3_destructor_type.self)
    
    @IBAction func addItem(_ sender: Any) {
        let brand = brandText.text!
        let type = typeText.text!
        let name = nameText.text!
        let category = categoryText.text!
        let price = Double(priceText.text!)!
        let insert = "INSERT INTO Items(brand, type, name, category, price, cart) VALUES(?, ?, ?, ?, ?, 0)"
        var stmt:OpaquePointer?
        
        
        if sqlite3_prepare(db, insert, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        
        if sqlite3_bind_text(stmt, 1, brand, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        
        if sqlite3_bind_text(stmt, 2, type, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        
        if sqlite3_bind_text(stmt, 3, name, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        
        if sqlite3_bind_text(stmt, 4, category, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        
        if sqlite3_bind_double(stmt, 5, price) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error biding price: \(err)")
            return
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(db))
            print("error executing insert: \(err)")
            return
        }
        else {
            brandText.text = ""
            typeText.text = ""
            nameText.text = ""
            categoryText.text = ""
            priceText.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
