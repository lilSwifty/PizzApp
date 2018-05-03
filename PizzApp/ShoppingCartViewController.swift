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

    //let pizza : Pizza? = nil
    
    let tables : [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    
    let greenColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
    let redColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
    let defaults = UserDefaults.standard
    let key = "AddToList"
    
    var pizzaNamesArray : [String] = []
    
    var confirmation : Bool = false
    
    @IBOutlet weak var placeOrderBtn: UIButton!
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var customerTable: UITextField!
    
    @IBOutlet weak var tableview: UITableView!
    
    var table = 0
    
    @IBAction func placeOrder(_ sender: UIButton) {
        checkOrder()
        authenticateUser()
        
    }
    
    
    // Bra funktion att ha när man testar sin kod för att lätt rensa sidan!
    @IBAction func orderServed(_ sender: UIButton) {
        resetAll()
    }
    
    func resetAll(){
        PizzaPreviewViewController.CustomerOrderList.customerOrder.removeAll()
        try! defaults.set(PropertyListEncoder().encode(PizzaPreviewViewController.CustomerOrderList.customerOrder), forKey: key)
        tableview.reloadData()
        priceLabel.text = "pris: \(PizzaPreviewViewController.CustomerOrderList.customerOrder.map({pizza in pizza.price}).reduce(0, +))0€"
        confirmation = false
        defaults.set(confirmation, forKey: "status")
        customerTable.text = ""
        defaults.set(self.customerTable.text, forKey: "customerTable")
        checkIfConfirmed()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.reloadData()
        confirmation = defaults.bool(forKey: "status")
        title = "Din beställning"
        checkIfConfirmed()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        priceLabel.text = "pris: \(PizzaPreviewViewController.CustomerOrderList.customerOrder.map({pizza in pizza.price}).reduce(0, +))0€"
        checkIfConfirmed()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func checkOrder(){
        if PizzaPreviewViewController.CustomerOrderList.customerOrder.isEmpty {
            self.placeOrderBtn.isHidden = true
            self.status.isHidden = true
        }
    }
    
    func confirmOrder(){
        self.status.text = "Bekräftad"
        confirmation = true
        defaults.set(confirmation, forKey: "status")
        checkIfConfirmed()
    }
    
    func checkIfConfirmed(){
        if confirmation == true {
            self.status.textColor = greenColor
            self.status.text = "Bekräftad"
        } else {
            self.status.textColor = redColor
            self.status.text = "Ej bekräftad"
        }
    }
    
    func saveThisToFireBase(pizza : [String], table : String ){
        let user = Auth.auth().currentUser?.email
        let username = user?.replacingOccurrences(of: ".", with: ",")
        
        
        let myDatabase = Database.database().reference().child("Orders").child("From table: \(table)").child(username!)
        
        
        myDatabase.setValue(pizzaNamesArray)
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
            let ac = UIAlertController(title: "Välj ett bord, tack!", message: "För upphämtning, välj '0' ", preferredStyle: .alert)
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
                            
                            for i in 0..<(PizzaPreviewViewController.CustomerOrderList.customerOrder.count){
                                self.pizzaNamesArray.append(PizzaPreviewViewController.CustomerOrderList.customerOrder[i].name)
                                self.saveThisToFireBase(pizza: self.pizzaNamesArray, table: self.customerTable.text!)
                                self.defaults.set(self.customerTable.text, forKey: "customerTable")
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
        return PizzaPreviewViewController.CustomerOrderList.customerOrder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "shoppingCell") as! ShoppingListTableViewCell
        
        cell.pizzaLabel.text = PizzaPreviewViewController.CustomerOrderList.customerOrder[indexPath.row].name
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            PizzaPreviewViewController.CustomerOrderList.customerOrder.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            try! defaults.set(PropertyListEncoder().encode(PizzaPreviewViewController.CustomerOrderList.customerOrder), forKey: key)
            tableView.reloadData()
            priceLabel.text = "pris: \(PizzaPreviewViewController.CustomerOrderList.customerOrder.map({pizza in pizza.price}).reduce(0, +))0€"
        }
    }
    
}

