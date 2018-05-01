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
import Firebase

class ShoppingCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var recievedOrder : [Pizza] = []
    
    let pizza : Pizza? = nil
    
    let tables : [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    
    let defaults = UserDefaults.standard
    let key = "AddToList"
    
    @IBOutlet weak var placeOrderBtn: UIButton!
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var customerTable: UITextField!
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBAction func placeOrder(_ sender: UIButton) {
        checkOrder()
        authenticateUser()
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.reloadData()
        
        
        
        title = "Din beställning"

    }
    
    override func viewDidAppear(_ animated: Bool) {
        priceLabel.text = "pris: \(recievedOrder.map({pizza in pizza.price}).reduce(0, +))0€"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkOrder(){
        if recievedOrder.isEmpty {
            self.placeOrderBtn.isHidden = true
            self.status.isHidden = true
        }
    }
    
    func confirmOrder(){
        self.status.text = "Bekräftad"
        self.status.textColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
    }
    
    func isStringAnInt(string: String) -> Bool {
        return Int(string) != nil
    }
    
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?
        var tableFound : Bool = false
        var orderStatus : Bool = false
        
        if status.text == "Bekräftad" {
            orderStatus = true
        }
        
        if let myTable = customerTable.text {
            if myTable == "hämta" || myTable == "Hämta" {
                tableFound = true
            } else if isStringAnInt(string: myTable) {
                if let intValueOfMyTable: Int = Int(myTable) {
                    if intValueOfMyTable >= 0 && intValueOfMyTable <= 20 {
                        tableFound = true
                    }
                }
            }
        } else {
            let ac = UIAlertController(title: "Ogiltigt bord!", message: "Var god och skriv ditt bord i fältet", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
        
        if  orderStatus {
            let ac = UIAlertController(title: "Håll ut!", message: "Dina pizzor är i snurr!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        } else if !tableFound {
            let ac = UIAlertController(title: "Välj ett bord, tack!", message: "För upphämtning, skriv 'hämta' ", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        } else {
            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
                let reason = "Bekräfta din beställning!"
                
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) {
                    [unowned self] success, authenticationError in
                    
                    DispatchQueue.main.async {
                        if success {
                            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                            
                            for i in 0..<(self.recievedOrder.count){
                                self.recievedOrder[i].saveToFirebase(pizza: [self.recievedOrder[i]])
                            }
                            
                            print("authentication succes! Drip drop!")
                            self.confirmOrder()
                            let ac = UIAlertController(title: "Succé!", message: "Din beställning är bekräftad", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .default))
                            self.present(ac, animated: true)
                            
                        } else {
                            let ac = UIAlertController(title: "Autentisering misslyckades", message: "var god, försök igen", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .default))
                            self.present(ac, animated: true)
                        }
                    }
                }
            } else {
                let ac = UIAlertController(title: "Touch ID ej tillgänglig", message: "Din enhet har inte Touch ID.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
            }
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
            tableView.deleteRows(at: [indexPath], with: .fade)
            try! defaults.set(PropertyListEncoder().encode(recievedOrder), forKey: key)
            tableView.reloadData()
            priceLabel.text = "pris: \(recievedOrder.map({pizza in pizza.price}).reduce(0, +))0€"
        }
    }
    
}

