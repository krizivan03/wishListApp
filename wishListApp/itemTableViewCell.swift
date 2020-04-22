//
//  itemTableViewCell.swift
//  wishListApp
//
//  Created by Christopher Canales on 3/21/20.
//  Copyright © 2020 Christopher Canales. All rights reserved.
//

import UIKit

class itemTableViewCell: UITableViewCell {
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        }

}
