//
//  TableViewCell.swift
//  Ricky and Morty
//
//  Created by Денис Иванов on 20.10.2019.
//  Copyright © 2019 Денис Иванов. All rights reserved.
//

import SDWebImage

class TableViewCell: UITableViewCell {
    
    @IBOutlet var myImage: UIImageView!
    @IBOutlet var myLabel: UILabel!
    
    func customizeCell(object: Сharacter?) {
        guard let character = object else { return }
        guard let urlImage = URL(string: character.image ?? "") else { return }
        myImage.sd_setImage(with: urlImage, completed: nil)
        myLabel.text = character.name
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myImage.image = nil
    }
}
