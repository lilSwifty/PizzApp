//
//  PizzaViewController.swift
//  PizzApp
//
//  Created by Mani Sedighi on 2018-04-13.
//  Copyright © 2018 Mani Sedighi. All rights reserved.
//

import UIKit
import Firebase

protocol SendPizzaData {
    func previewSelectedPizza(pizza : Pizza)
}

class PizzaViewController: UIViewController {
    
    
    let defaults = UserDefaults.standard
    let key = "AddToList"
    
    var listOfAllPizzas = [Pizza]()
    var listOfAllPanPizzas = [Pizza]()
    var listOfAllSpecialPizzas = [Pizza]()
    
    var recievedOrder = PizzaPreviewViewController.CustomerOrderList.customerOrder
    
    var expandCell = false
    
    var pizzaToSend : Pizza?
    
    let imageview = UIImageView(image: #imageLiteral(resourceName: "oldPaper"))
    
    let sectionNormalPizza = 0
    let sectionPanPizza = 1
    let sectionSpecialPizza = 2
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var goToCart: UIButton!
    
    @IBAction func logout(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        
        let backItem = UIBarButtonItem()
        backItem.title = "Tillbaka"
        navigationItem.backBarButtonItem = backItem
        
        updatePizzaInformation()
        
        try! defaults.set(PropertyListEncoder().encode(PizzaPreviewViewController.CustomerOrderList.customerOrder), forKey: key)
        
        print("antal \(listOfAllPizzas.count + listOfAllPanPizzas.count + listOfAllSpecialPizzas.count)")
        tableview.backgroundView = imageview
        
        print("Order recieved: \(recievedOrder)")
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        checkIfCartIsEmpty()
        let selectedRow: IndexPath? = tableview.indexPathForSelectedRow
        if let selectedRowNotNill = selectedRow {
            tableview.deselectRow(at: selectedRowNotNill, animated: false)
        }
        print("Order recieved: \(PizzaPreviewViewController.CustomerOrderList.customerOrder)")
    }
    
    func checkIfCartIsEmpty(){
        if PizzaPreviewViewController.CustomerOrderList.customerOrder.isEmpty {
            self.goToCart.isHidden = true
        } else {
            self.goToCart.isHidden = false
        }
    }
    
}


extension PizzaViewController: UITableViewDelegate, UITableViewDataSource{
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return listOfAllPizzas.count
        case 1:
            return listOfAllPanPizzas.count
        case 2:
            return listOfAllSpecialPizzas.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "pizzacell") as! CustomPizzaCell
            
        
        if indexPath.section == 0 {
            cell.pizzaLabel.text = listOfAllPizzas[indexPath.row].name
            cell.toppingLabel.text = String (describing: listOfAllPizzas[indexPath.row].topping.joined(separator: ", "))
            cell.priceLabel.text = "\(listOfAllPizzas[indexPath.row].price)0€"
        }
        
        else if indexPath.section == 1 {
            cell.pizzaLabel.text = listOfAllPanPizzas[indexPath.row].name
            cell.toppingLabel.text = String (describing: listOfAllPanPizzas[indexPath.row].topping.joined(separator: ", "))
            cell.priceLabel.text = "\(listOfAllPanPizzas[indexPath.row].price)0€"
        }
        
        else if indexPath.section == 2 {
            cell.pizzaLabel.text = listOfAllSpecialPizzas[indexPath.row].name
            cell.toppingLabel.text = String (describing: listOfAllSpecialPizzas[indexPath.row].topping.joined(separator: ", "))
            cell.priceLabel.text = "\(listOfAllSpecialPizzas[indexPath.row].price)0€"
        }
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 75.0
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).backgroundView?.backgroundColor = UIColor.red.withAlphaComponent(0.6)
        (view as! UITableViewHeaderFooterView).textLabel?.adjustsFontSizeToFitWidth = true
        
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showPizza", sender: self)
        
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if let destinationVC = segue.destination as? PizzaPreviewViewController{

                switch tableview.indexPathForSelectedRow?.section {
                case 0:
                    destinationVC.pizzaToOrder = listOfAllPizzas[(tableview.indexPathForSelectedRow?.row)!]
                    print("You chose: \(listOfAllPizzas[(tableview.indexPathForSelectedRow?.row)!].name)")
                case 1:
                    destinationVC.pizzaToOrder = listOfAllPanPizzas[(tableview.indexPathForSelectedRow?.row)!]
                    print("You chose: \(listOfAllPanPizzas[(tableview.indexPathForSelectedRow?.row)!].name)")
                case 2:
                    destinationVC.pizzaToOrder = listOfAllSpecialPizzas[(tableview.indexPathForSelectedRow?.row)!]
                    print("You chose: \(listOfAllSpecialPizzas[(tableview.indexPathForSelectedRow?.row)!].name)")
                default : break
                }

            }
    
        }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(white: 1, alpha: 0.3)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Dallas Regular Pizza"
        case 1:
            return "Dallas Pan Pizza"
        case 2:
            return "Dallas Special Pizza"
        default:
            return nil
        }
    }
    
    
}

extension PizzaViewController {
    func updatePizzaInformation(){
        
//        var listOfAllToppings : [String : Double] = ["1 Champnjoner" : 1.1,
//                                                     "2 Ananas" : 1.1,
//                                                     "3 Paprika" : 1.1,
//                                                     "4 Lök" : 1.1,
//                                                     "5 Syltlök" : 1.1,
//                                                     "6 Oliver" : 1.1,
//                                                     "7 Majs" : 1.1,
//                                                     "8 Saltgurka" : 1.1,
//                                                     "9 Jalapeno" : 1.1,
//                                                     "10 Chilisås" : 1.1,
//                                                     "11 Vitlök" : 1.1,
//                                                     "12 Skinka" : 1.3,
//                                                     "13 Bacon" : 1.3,
//                                                     "14 Salami" : 1.3,
//                                                     "15 Maletköttsås" : 1.3,
//                                                     "16 Ägg" : 1.3,
//                                                     "17 Anjovis" : 1.3,
//                                                     "18 Ost" : 1.3,
//                                                     "19 Fetaost" : 1.3,
//                                                     "20 Auraost" : 1.3,
//                                                     "21 Färsk tomat" : 1.3,
//                                                     "22 Banan" : 1.3,
//                                                     "23 Kebabkött" : 1.6,
//                                                     "24 Bearneisesås" : 1.6,
//                                                     "25 Soltorkade tomater" : 1.6,
//                                                     "26 Tonfisk" : 1.6,
//                                                     "27 Räkor" : 1.6,
//                                                     "28 Musslor" : 1.6,
//                                                     "19 Oxinrefilé" : 4.1]
//
        
        // All regular pizzas :
        let mexicana = Pizza(name: "Mexicana", topping: ["Maletköttsås", "Paprika", "Majs"], price: 11.30)
        listOfAllPizzas.append(mexicana)
        
        let capricciosa = Pizza(name: "Capricciosa", topping: ["Skinka", "Champinjoner"], price: 11.70)
        listOfAllPizzas.append(capricciosa)
        
        let fruttiDiMare = Pizza(name: "Frutti Di Mare", topping: ["Musslor", "Räkor"], price: 10.90)
        listOfAllPizzas.append(fruttiDiMare)
        
        let operaSpecial = Pizza(name: "Opera Special", topping: ["Skinka" , "Tonfisk" , "Salami"], price: 11.70)
        listOfAllPizzas.append(operaSpecial)
        
        let osoleMio = Pizza(name: "O'Sole Mio", topping: ["Tonfisk", "Räkor"], price: 10.90)
        listOfAllPizzas.append(osoleMio)
        
        let bussola = Pizza(name: "Bussola", topping: ["Skinka", "Räkor"], price: 10.90)
        listOfAllPizzas.append(bussola)
        
        let opera = Pizza(name: "Opera", topping: ["Skinka", "Tonfisk"], price: 10.90)
        listOfAllPizzas.append(opera)
        
        let siciliana = Pizza(name: "Siciliana", topping: ["Anjovis", "Oliver", "Vitlök"], price: 11.30)
        listOfAllPizzas.append(siciliana)
        
        let calzone = Pizza(name: "Calzone", topping: ["Skinka", "inbakad"], price: 11.90)
        listOfAllPizzas.append(calzone)
        
        let vegetariana = Pizza(name: "Vegetariana", topping: ["Champinjoner", "Lök", "Paprika", "Oliver", "Ananas"], price: 12.30)
        listOfAllPizzas.append(vegetariana)
        
        let americana = Pizza(name: "Americana", topping: ["Skinka", "Ananas", "Auraost"], price: 11.50)
        listOfAllPizzas.append(americana)
        
        let vesuvio = Pizza(name: "Vesuvio", topping: ["Skinka"], price: 9.50)
        listOfAllPizzas.append(vesuvio)
        
        let quattro = Pizza(name: "Quattro Stagioni", topping: ["Skinka", "Champinjoner", "Räkor", "Musslor" ], price: 12.10)
        listOfAllPizzas.append(quattro)
        
        let cacciatora = Pizza(name: "Cacciatora", topping: ["Salami", "Oliver"], price: 10.70)
        listOfAllPizzas.append(cacciatora)
        
        // All pan pizzas :
        
        let peterpan = Pizza(name: "Peter Pan", topping: ["Skinka", "Champinjoner", "Ananas"], price: 10.90)
        listOfAllPanPizzas.append(peterpan)
        
        let streetman = Pizza(name: "Streetman", topping: ["Maletköttsås", "Salami", "Lök","Paprika"], price: 11.70)
        listOfAllPanPizzas.append(streetman)
        
        let texaspan = Pizza(name: "Texas Pan", topping: ["Bacon", "Syltlök", "Auraost"], price: 11.10)
        listOfAllPanPizzas.append(texaspan)
        
        let fruitland = Pizza(name: "Fruitland", topping: ["Champinjoner", "Ananas","Lök", "Oliver"], price: 11.30)
        listOfAllPanPizzas.append(fruitland)
        
        let trinity = Pizza(name: "Trinity River", topping: ["Tonfisk", "Räkor", "Lök"], price: 11.10)
        listOfAllPanPizzas.append(trinity)
        
        let regency = Pizza(name: "Regency", topping: ["Skinka", "Ananas", "Auraost"], price: 11.10)
        listOfAllPanPizzas.append(regency)
        
        let dalhart = Pizza(name: "Dalhart", topping: ["Salami", "Lök", "Paprika", "Saltgurka", "Auraost"], price: 12.30)
        listOfAllPanPizzas.append(dalhart)
        
        // All special pizzas :
        
        let sophia = Pizza(name: "Sophia Loren", topping: ["Bacon", "Ananas", "Ägg"], price: 11.50)
        listOfAllSpecialPizzas.append(sophia)
        
        let pompeij = Pizza(name: "Pompeij", topping: ["Bacon", "Lök"], price: 10.70)
        listOfAllSpecialPizzas.append(pompeij)
        
        let pekkas = Pizza(name: "Pekkas Special", topping: ["Skinka","Champinjoner", "Räkor", "Ananas", "Auraost" ], price: 12.90)
        listOfAllSpecialPizzas.append(pekkas)
        
        let calzoneD = Pizza(name: "Calzone a'la Dallas", topping: ["Skinka", "Lök", "Champinjoner", "Auraost", "inbakad"], price: 13.50)
        listOfAllSpecialPizzas.append(calzoneD)
        
        let vegeDallas = Pizza(name: "Vegetariana a'la Dallas", topping: ["Champinjoner", "Lök", "Paprika", "Oliver", "Ananas", "Auraost"], price: 13.10)
        listOfAllSpecialPizzas.append(vegeDallas)
        
        let balaton = Pizza(name: "Balaton", topping: ["Salami", "Saltgurka", "Lök", "Auraost"], price: 12.10)
        listOfAllSpecialPizzas.append(balaton)
        
        let westerwik = Pizza(name: "Pizza Westerwik", topping: ["Maletköttsås", "Saltgurka", "Champinjoner", "Lök"], price: 11.90)
        listOfAllSpecialPizzas.append(westerwik)
        
        let diablo = Pizza(name: "Diablo (stark)", topping: ["Chilisås", "Pepperonisalami", "Ananas", "Lök", "Jalapeno"], price: 12.50)
        listOfAllSpecialPizzas.append(diablo)
        
        let dallas = Pizza(name: "Dallas", topping: ["Oxinnerfilé 2 x 50 g", "Majs", "Lök", "Ägg"], price: 18.50)
        listOfAllSpecialPizzas.append(dallas)
        
        let dallasSpecial = Pizza(name: "Dallas Special", topping: ["Oxinnerfilé 2 x 50 g", "Majs", "Lök", "Auraost"], price: 19.10)
        listOfAllSpecialPizzas.append(dallasSpecial)
        
        let bobafett = Pizza(name: "Boba Fett", topping: ["Strimlad oxinnerfilé 50g", "Fetaost", "Skivad tomat"], price: 15.70)
        listOfAllSpecialPizzas.append(bobafett)
        
        let banana = Pizza(name: "Banana", topping: ["Skinka", "Banan", "Curry"], price: 11.50)
        listOfAllSpecialPizzas.append(banana)
        
        let sweden = Pizza(name: "Dr. Sweden", topping: ["Kebab", "Soltorkade tomater", "Bearneisesås"], price: 12.60)
        listOfAllSpecialPizzas.append(sweden)

    }
}
