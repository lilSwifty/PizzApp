//
//  Pizza.swift
//  PizzApp
//
//  Created by Mani Sedighi on 2018-04-13.
//  Copyright © 2018 Mani Sedighi. All rights reserved.
//

import Foundation

class Pizza {
    var name : String
    var topping : Array<String>
    var price : Double
    var amount : Int
    
    init(name: String, topping: Array<String>, price: Double, amount: Int) {
        self.name = name
        self.topping = topping
        self.price = price
        self.amount = amount
    }
    
    
}
