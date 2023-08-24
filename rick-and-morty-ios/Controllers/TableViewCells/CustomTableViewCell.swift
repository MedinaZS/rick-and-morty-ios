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
//        self.viewWithTag(1)?.layer.cornerRadius = 10
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageField.image = nil
        nameField.text = nil
        statusField.text = nil
        specieField.text = nil
    }
    
    public func fillFields (with viewModel: RMCharacterTableViewCellViewModel){
        
        nameField.text = viewModel.characterName
        statusField.text = viewModel.characterStatusText
        specieField.text = viewModel.characterSpecie
        iconStatus.text = viewModel.characterStatus == .alive ? "🟢" : "⚪️"
        let url = URL(string: viewModel.characterImage)
        imageField.kf.setImage(with: url)
    }
    
    
    
}
