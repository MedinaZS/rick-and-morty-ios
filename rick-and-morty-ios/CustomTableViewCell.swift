//
//  CustomTableViewCell.swift
//  rick-and-morty-ios
//
//  Created by Montserrat Medina on 2023-08-23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "CustomCell"

    @IBOutlet weak var specieField: UILabel!
    @IBOutlet weak var statusField: UILabel!
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var iconStatus: UILabel!
    
    @IBOutlet weak var imageField: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
