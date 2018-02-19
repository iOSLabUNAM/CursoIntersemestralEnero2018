//
//  SuperTableViewCell.swift
//  MarvelApi
//
//  Created by macbook on 15/01/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class SuperTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabelCell: UILabel!
    
    @IBOutlet weak var imageViewCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
