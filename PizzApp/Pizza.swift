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
    
    func saveToFirebase(pizza : [Pizza]){
        
        let user = Auth.auth().currentUser?.email
        
        let username = user?.replacingOccurrences(of: ".", with: ",")
       
        var listOfPizzas : [Pizza] = pizza
        print(listOfPizzas)
        
        //första versionen:
        //let myDatabase = Database.database().reference().child("Orders").child(Auth.auth().currentUser!.uid).childByAutoId()
        
        //let myDatabase = Database.database().reference().child("Orders").child(username!).childByAutoId().child("table")
        
        let myDatabase = Database.database().reference().child("Orders").child("Table").child(username!).childByAutoId()
        
        //let dictionary = ["pizza" : self.name, "price" : self.price] as [String : Any]
        let thisOrder = ["pizza" : self.name]
        
        
        for pizza in listOfPizzas{
            myDatabase.setValue(thisOrder)

        }
        
        
    }
    
}
