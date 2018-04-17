//
//  PizzaPreviewViewController.swift
//  PizzApp
//
//  Created by Mani Sedighi on 2018-04-15.
//  Copyright © 2018 Mani Sedighi. All rights reserved.
//

import UIKit



class PizzaPreviewViewController: UIViewController{

    
    var pizzaToOrder:Pizza?
    
    
    
    
    @IBOutlet weak var pizzaName: UILabel!
    @IBOutlet weak var topping1: UILabel!
    @IBOutlet weak var topping2: UILabel!
    @IBOutlet weak var topping3: UILabel!
    @IBOutlet weak var topping4: UILabel!
    @IBOutlet weak var topping5: UILabel!
    @IBOutlet weak var topping6: UILabel!
    
    @IBOutlet weak var remove1: UIButton!
    @IBOutlet weak var remove2: UIButton!
    @IBOutlet weak var remove3: UIButton!
    @IBOutlet weak var remove4: UIButton!
    @IBOutlet weak var remove5: UIButton!
    @IBOutlet weak var remove6: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pizzaName.text = pizzaToOrder?.name
        setToppings()
    }
    
    
    @IBAction func removeBtn1(_ sender: UIButton) {
        print("Button 1")
        let firstTopping = pizzaToOrder?.topping[0]
        if firstTopping != "" {
            pizzaToOrder?.topping[0] = ""
            setToppings()
        }
    }
    @IBAction func removeBtn2(_ sender: UIButton) {
        print("Button 2")
        let secondTopping = pizzaToOrder?.topping[1]
        if  secondTopping != "" {
            pizzaToOrder?.topping[1] = ""
            setToppings()
        }
    }
    @IBAction func removeBtn3(_ sender: UIButton) {
        print("Button 3")
        let thirdTopping = pizzaToOrder?.topping[2]
        if  thirdTopping != "" {
            pizzaToOrder?.topping[2] = ""
            setToppings()
        }
    }
    @IBAction func removeBtn4(_ sender: UIButton) {
        print("Button 4")
        let forthTopping = pizzaToOrder?.topping[3]
        if  forthTopping != "" {
            pizzaToOrder?.topping[3] = ""
            setToppings()
        }
    }
    @IBAction func removeBtn5(_ sender: UIButton) {
        print("Button 5")
        let fifthTopping = pizzaToOrder?.topping[4]
        if fifthTopping != "" {
            pizzaToOrder?.topping[4] = ""
            setToppings()
        }
    }
    @IBAction func removeBtn6(_ sender: UIButton) {
        print("Button 6")
        let sixtTopping = pizzaToOrder?.topping[5]
        if sixtTopping != "" {
            pizzaToOrder?.topping[5] = ""
            setToppings()
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
            remove2.isHidden = false
            remove3.isHidden = false
            remove4.isHidden = false
            remove5.isHidden = false
            remove6.isHidden = false
        } else if numberOfToppings == 2 {
            topping1.text = pizzaToOrder?.topping[0]
            topping2.text = pizzaToOrder?.topping[1]
            topping3.alpha = 0.0
            topping4.alpha = 0.0
            topping5.alpha = 0.0
            topping6.alpha = 0.0
            remove3.isHidden = true
            remove4.isHidden = true
            remove5.isHidden = true
            remove6.isHidden = true
        } else if numberOfToppings == 3 {
            topping1.text = pizzaToOrder?.topping[0]
            topping2.text = pizzaToOrder?.topping[1]
            topping3.text = pizzaToOrder?.topping[2]
            topping4.alpha = 0.0
            topping5.alpha = 0.0
            topping6.alpha = 0.0
            remove4.isHidden = true
            remove5.isHidden = true
            remove6.isHidden = true
        } else if numberOfToppings == 4 {
            topping1.text = pizzaToOrder?.topping[0]
            topping2.text = pizzaToOrder?.topping[1]
            topping3.text = pizzaToOrder?.topping[2]
            topping4.text = pizzaToOrder?.topping[3]
            topping5.alpha = 0.0
            topping6.alpha = 0.0
            remove5.isHidden = true
            remove6.isHidden = true
        } else if numberOfToppings == 5 {
            topping1.text = pizzaToOrder?.topping[0]
            topping2.text = pizzaToOrder?.topping[1]
            topping3.text = pizzaToOrder?.topping[2]
            topping4.text = pizzaToOrder?.topping[3]
            topping5.text = pizzaToOrder?.topping[4]
            topping6.alpha = 0.0
            remove6.isHidden = true
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
