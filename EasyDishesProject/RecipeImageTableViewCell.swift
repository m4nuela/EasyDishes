//
//  RecipeImageTableViewCell.swift
//  EasyDishesProject
//
//  Created by Nicolas Oliveira Gomes do Nascimento on 2/28/16.
//  Copyright © 2016 Manuela Barbosa. All rights reserved.
//

import UIKit

class RecipeImageTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
