//
//  CustomPizzaCell.swift
//  PizzApp
//
//  Created by Mani Sedighi on 2018-04-13.
//  Copyright © 2018 Mani Sedighi. All rights reserved.
//

import UIKit

protocol CellButtonDelegate {
    func didPressAdd()
    func didPressRemove()
}

class CustomPizzaCell: UITableViewCell {

    @IBOutlet weak var pizzaLabel: UILabel!
    @IBOutlet weak var toppingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var removeLabel: UIButton!
    @IBOutlet weak var addLabel: UIButton!
    
    
    var delegate : CellButtonDelegate?
    
    @IBOutlet weak var amountOfPizza: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addPizza(_ sender: UIButton) {
        delegate?.didPressAdd()
    }
    
    @IBAction func removePizza(_ sender: UIButton) {
        delegate?.didPressRemove()
    }
    
}
