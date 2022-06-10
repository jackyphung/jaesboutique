//
//  ItemDetail.swift
//  jaesboutique
//
//  Created by Jacky Phung on 2019-03-21.
//  Copyright © 2019 Jacky Phung. All rights reserved.
// Jacky Phung 100801047
// Jarone Rodney 101077225
// Charles Santiago 101084441
// Jullian Sy-Lucero 100998164

import UIKit
import SQLite3

class CartDetailController: UIViewController {
    var db:OpaquePointer?
    @IBOutlet weak var brandText: UILabel!
    @IBOutlet weak var typeText: UILabel!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var categoryText: UILabel!
    @IBOutlet weak var priceText: UILabel!
    
    var item:Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let i = item {
            brandText.text = i.brand
            typeText.text = i.type
            nameText.text = i.name
            categoryText.text = i.category
            priceText.text = "$\(i.price)"
        }
    }
    
    @IBAction func cart(_ sender: Any) {
        let update = "UPDATE Items SET cart = 0 WHERE id = ?"
        var stmt:OpaquePointer?
        
        if sqlite3_prepare(db, update, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error preparing statement: \(err)")
            return
        }
        
        if sqlite3_bind_int(stmt, 1, Int32(item!.id)) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db))
            print("error biding price: \(err)")
            return
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(db))
            print("error executing insert: \(err)")
            return
        }

        defer {
            sqlite3_finalize(stmt)
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
