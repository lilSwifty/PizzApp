//
//  PizzaViewController.swift
//  PizzApp
//
//  Created by Mani Sedighi on 2018-04-13.
//  Copyright © 2018 Mani Sedighi. All rights reserved.
//

import UIKit

class PizzaViewController: UIViewController {
    
    //var amount = 0
    let listOfAllPizzas : [String] = ["Mexicana","Capricciosa", "Frutti Di Mare", "Opera Special", "O'Sole Mio", "Bussola", "Opera", "Siciliana", "Calzone", "Vegetariana", "Americana", "Vesuvio", "Quattro Stagioni", "Cacciatora", "Peter Pan", "Streetman", "Texas Pan", "Fruitland", "Trinityriver", "Regency", "Dalhart", "Sophia Loren", "Pompeij", "Pekkas Special", "Calzone a'la Dallas", "Vegetariana a'la Dallas", "Balaton", "Pizza Westervik", "Diablo (stark)", "Dallas", "Dallas Special", "Boba Fett", "Banana", "Dr. Sweden"]
    
    @IBOutlet weak var tableview: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        print("antal \(listOfAllPizzas.count)")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}

extension PizzaViewController: CellButtonDelegate {

    func didPressAdd() {
        
        
//        amount += 1
//        print(amount)
        tableview.reloadData()
    }

    func didPressRemove() {

        
        
//        if amount > 0 {
//            amount -= 1
//            tableview.reloadData()
//            print(amount)
//        } else {
//            print("amount is zero")
//        }
//    }

}

extension PizzaViewController: UITableViewDelegate, UITableViewDataSource{
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfAllPizzas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "pizzacell") as! CustomPizzaCell
        //cell.pizzaLabel.layer.cornerRadius = cell.pizzaLabel.frame.height / 2
        cell.delegate = self
        
        
        cell.amountOfPizza.text = String(amount)
        
        cell.pizzaLabel.text = listOfAllPizzas[indexPath.row]
        cell.toppingLabel.text = "tomato, cheese"
        cell.priceLabel.text = "12€"
        
//        func didPressAdd(){
//            cell.amountOfPizza.text = String("\(amount += 1)")
//            print(amount)
//        }
//
//        func didPressRemove(){
//            if amount > 0{
//                cell.amountOfPizza.text = String("\(amount -= 1)")
//                print(amount)
//            } else {
//                print("amount is zero")
//            }
//
//        }
        
        return cell
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You chose: \(listOfAllPizzas[indexPath.row])")
        
    }
}
