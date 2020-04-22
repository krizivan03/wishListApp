//
//  matchingLocTableViewCell.swift
//  wishListApp
//
//  Created by Christopher Canales on 4/18/20.
//  Copyright © 2020 Christopher Canales. All rights reserved.
//

import UIKit

class matchingLocTableViewCell: UITableViewCell {
    
    

    @IBOutlet weak var aMatchingLoc: UILabel!
    @IBOutlet weak var matchingLocAdress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
