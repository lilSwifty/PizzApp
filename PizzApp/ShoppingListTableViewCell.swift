//
//  ShoppingListTableViewCell.swift
//  PizzApp
//
//  Created by Mani Sedighi on 2018-04-26.
//  Copyright © 2018 Mani Sedighi. All rights reserved.
//

import UIKit

class ShoppingListTableViewCell: UITableViewCell {
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var pizzaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
