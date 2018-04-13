//
//  PizzaViewController.swift
//  PizzApp
//
//  Created by Mani Sedighi on 2018-04-13.
//  Copyright © 2018 Mani Sedighi. All rights reserved.
//

import UIKit

class PizzaViewController: UIViewController {
    
    var listOfAllPizzas = [Pizza]()
    var listOfAllPanPizzas = [Pizza]()
    var listOfAllSpecialPizzas = [Pizza]()
    
    var expandCell = false
    var amount = 0
    
    
    @IBOutlet weak var tableview: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        print("antal \(listOfAllPizzas.count)")
        updatePizzaInformation()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}

extension PizzaViewController: CellButtonDelegate {

    func didPressAdd() {
        
//        guard let cell = _sender.superview?.superview as? CustomPizzaCell else {
//            return // or fatalError() or whatever
//        }
//
//        let indexPath = tableview.indexPath(for: cell)
        
        amount += 1
        print(amount)
        tableview.reloadData()
    }

    func didPressRemove() {
        if amount > 0 {
            amount -= 1
            tableview.reloadData()
            print(amount)
        } else {
            print("amount is zero")
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
        //cell.pizzaLabel.layer.cornerRadius = cell.pizzaLabel.frame.height / 2
        cell.delegate = self
        
        
        cell.amountOfPizza.text = String(amount)
        
        
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
        print("You chose: \(listOfAllPizzas[indexPath.row])")

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
