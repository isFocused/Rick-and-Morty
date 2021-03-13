//
//  CharacterViewCell.swift
//  Rick and Morty
//
//  Created by Денис Иванов on 20.10.2019.
//  Copyright © 2019 Денис Иванов. All rights reserved.
//

import SDWebImage

class CharacterViewCell: UITableViewCell {
    
    static let reuseIdentifaer = "Cell"
    
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    func сonfigureСell(object: Сharacter?) {
        guard let character = object else { return }
        guard let imageUrl = URL(string: character.image) else { return }
        avatarImageView.sd_setImage(with: imageUrl,
                                    placeholderImage: #imageLiteral(resourceName: "noImage"),
                                    options: .highPriority,
                                    context: nil)
        titleLabel.text = character.name
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
    }
}
