//
//  HomeTableViewCell.swift
//  Inventroy System
//
//  Created by Ahmed Nasr on 11/23/20.
//

import UIKit
import CoreData

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var SaleButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
