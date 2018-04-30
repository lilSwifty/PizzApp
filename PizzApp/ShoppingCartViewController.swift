//
//  ShoppingCartViewController.swift
//  PizzApp
//
//  Created by Mani Sedighi on 2018-04-26.
//  Copyright © 2018 Mani Sedighi. All rights reserved.
//

import UIKit
import LocalAuthentication
import AudioToolbox

class ShoppingCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var recievedOrder : [Pizza] = []
    
    let pizza : Pizza? = nil
    
    
    let defaults = UserDefaults.standard
    let key = "AddToList"
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBAction func placeOrder(_ sender: UIButton) {
        authenticateUser()
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.reloadData()
        
        priceLabel.text = "pris: \(recievedOrder.map({pizza in pizza.price}).reduce(0, +))"
        
        title = "Your order"
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Confirm order!"
            
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) {
                [unowned self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                        for i in 0..<(self.recievedOrder.count){
                            self.recievedOrder[i].saveToFirebase(pizza: [self.recievedOrder[i]])
                        }
                        print("authentication succes! Drip drop!")
                        
                    } else {
                        let ac = UIAlertController(title: "Authentication failed", message: "Try again to place your order", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(ac, animated: true)
                    }
                }
            }
        } else {
            let ac = UIAlertController(title: "Touch ID not available", message: "Your device is not configured for Touch ID.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recievedOrder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "shoppingCell") as! ShoppingListTableViewCell
        
        cell.pizzaLabel.text = recievedOrder[indexPath.row].name
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            recievedOrder.remove(at: indexPath.row)
            try! defaults.set(PropertyListEncoder().encode(recievedOrder), forKey: key)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

