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
       
        var listOfPizzas : [Pizza] = pizza
        print(listOfPizzas)
        let myDatabase = Database.database().reference().child("Pizza").child(Auth.auth().currentUser!.uid).childByAutoId()
        let dictionary = ["pizza" : self.name, "price" : self.price] as [String : Any]
        
        for pizza in listOfPizzas{
            myDatabase.setValue(dictionary)

        }
        
        
        
        
        
//
        
    }
    
}
