//
//  HomeTableViewCell.swift
//  Inventroy System
//
//  Created by Ahmed Nasr on 11/23/20.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func saleQuantityOnClick(_ sender: UIButton){
        var quantity = Int(quantityLabel.text!)
        if quantity != 0{
            quantity = quantity! - 1
            quantityLabel.text = String(quantity!)
            //save change in CoreData
        }else if quantity == 0{
            print("Can't")
        }
    }
}
