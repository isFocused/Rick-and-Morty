//
//  TableViewCell.swift
//  Rick and Morty
//
//  Created by Денис Иванов on 20.10.2019.
//  Copyright © 2019 Денис Иванов. All rights reserved.
//

import SDWebImage

class TableViewCell: UITableViewCell {
    
    @IBOutlet var myImage: UIImageView!
    @IBOutlet var myLabel: UILabel!
    
    func сonfigureСell(object: Сharacter?) {
        guard let character = object else { return }
        guard let imageUrl = URL(string: character.image) else { return }
        myImage.sd_setImage(with: imageUrl,
                            placeholderImage: UIImage(named: "noImage"),
                            options: .highPriority,
                            context: nil)
        myLabel.text = character.name
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myImage.image = nil
    }
}
