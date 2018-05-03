//
//  Pizza.swift
//  PizzApp
//
//  Created by Mani Sedighi on 2018-04-13.
//  Copyright © 2018 Mani Sedighi. All rights reserved.
//

import Foundation
import Firebase


class Pizza : Codable {
    var name : String
    var topping : Array<String>
    var price : Double
    
    
    init(name: String, topping: Array<String>, price: Double) {
        self.name = name
        self.topping = topping
        self.price = price
    }
    
//    func saveToFirebase(pizza : [Pizza], table : String){
//        var table = table
//        let user = Auth.auth().currentUser?.email
//        let username = user?.replacingOccurrences(of: ".", with: ",")
//
//
//
//
//        let myDatabase = Database.database().reference().child("Orders").child("From table: \(table)").child(username!)
//
//        thisOrder = ["pizza" : self.name]
//        myDatabase.setValue(thisOrder)
//
//
//
//        let dictionary = ["pizza" : self.name, "price" : self.price] as [String : Any]
//
//
//        första versionen:
//        let myDatabase = Database.database().reference().child("Orders").child(Auth.auth().currentUser!.uid).childByAutoId()
//
//        let myDatabase = Database.database().reference().child("Orders").child(username!).childByAutoId().child("table")
//
//    }
    
}
