//
//  Item.swift
//  jaesboutique
//
//  Created by Jacky Phung on 2019-03-20.
//  Copyright © 2019 Jacky Phung. All rights reserved.
// Jacky Phung 100801047
// Jarone Rodney 101077225
// Charles Santiago 101084441
// Jullian Sy-Lucero 100998164

import Foundation

class Item {
    var id:Int
    var brand:String
    var type:String
    var name:String
    var category:String
    var price:Double
    var cart:Bool
    
    init(id: Int, brand: String, type:String, name:String, category:String, price:Double) {
        self.id = id
        self.brand = brand
        self.type = type
        self.name = name
        self.category = category
        self.price = price
        self.cart = false
    }
}
