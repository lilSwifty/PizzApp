//
//  PizzaPreviewViewController.swift
//  PizzApp
//
//  Created by Mani Sedighi on 2018-04-15.
//  Copyright © 2018 Mani Sedighi. All rights reserved.
//

import UIKit


class PizzaPreviewViewController: UIViewController{

    let defaults = UserDefaults.standard
    let key = "AddToList"
    
    var pizzaToOrder:Pizza?
    
    var orderList : [String] = []
    var totalPrice : Double = 0.0
    
    var order : [Pizza] = []
    
    
    
    @IBOutlet weak var pizzaName: UILabel!
    @IBOutlet weak var topping1: UILabel!
    @IBOutlet weak var topping2: UILabel!
    @IBOutlet weak var topping3: UILabel!
    @IBOutlet weak var topping4: UILabel!
    @IBOutlet weak var topping5: UILabel!
    @IBOutlet weak var topping6: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pizzaName.text = "\(pizzaToOrder!.name)   \(pizzaToOrder!.price)0€"
        
        setToppings()
        if let data = defaults.object(forKey: key) as? Data {
            if let pizzaList = try? PropertyListDecoder().decode([Pizza].self, from: data){
                order = pizzaList
            }
        }
        
        
        
        print("View did load: \(orderList)")
    }
    
    
    
    @IBAction func addToCart(_ sender: UIButton) {
        order.append(pizzaToOrder!)
        try! defaults.set(PropertyListEncoder().encode(order), forKey: key)
        print("Button pressed: \(order)")
        
    }
    
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ShoppingCartViewController {

            destinationVC.recievedOrder = order
        }
    }
    
    func setToppings(){
        
        let numberOfToppings = pizzaToOrder?.topping.count
        
        if numberOfToppings == 1 {
            topping1.text = pizzaToOrder?.topping[0]
            topping2.alpha = 0.0
            topping3.alpha = 0.0
            topping4.alpha = 0.0
            topping5.alpha = 0.0
            topping6.alpha = 0.0
        } else if numberOfToppings == 2 {
            topping1.text = pizzaToOrder?.topping[0]
            topping2.text = pizzaToOrder?.topping[1]
            topping3.alpha = 0.0
            topping4.alpha = 0.0
            topping5.alpha = 0.0
            topping6.alpha = 0.0
        } else if numberOfToppings == 3 {
            topping1.text = pizzaToOrder?.topping[0]
            topping2.text = pizzaToOrder?.topping[1]
            topping3.text = pizzaToOrder?.topping[2]
            topping4.alpha = 0.0
            topping5.alpha = 0.0
            topping6.alpha = 0.0
        } else if numberOfToppings == 4 {
            topping1.text = pizzaToOrder?.topping[0]
            topping2.text = pizzaToOrder?.topping[1]
            topping3.text = pizzaToOrder?.topping[2]
            topping4.text = pizzaToOrder?.topping[3]
        } else if numberOfToppings == 5 {
            topping1.text = pizzaToOrder?.topping[0]
            topping2.text = pizzaToOrder?.topping[1]
            topping3.text = pizzaToOrder?.topping[2]
            topping4.text = pizzaToOrder?.topping[3]
            topping5.text = pizzaToOrder?.topping[4]
        } else if numberOfToppings == 6 {
            topping1.text = pizzaToOrder?.topping[0]
            topping2.text = pizzaToOrder?.topping[1]
            topping3.text = pizzaToOrder?.topping[2]
            topping4.text = pizzaToOrder?.topping[3]
            topping5.text = pizzaToOrder?.topping[4]
            topping6.text = pizzaToOrder?.topping[5]
        }
    }
    



}
