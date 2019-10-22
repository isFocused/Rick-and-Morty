//
//  TableViewCell.swift
//  Ricky and Morty
//
//  Created by Денис Иванов on 20.10.2019.
//  Copyright © 2019 Денис Иванов. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet var myImage: UIImageView!
    @IBOutlet var myLabel: UILabel!
    
    func customizeCell(object: Сharacter?) {
        myLabel.text = object?.name
        DispatchQueue.global().async {
            guard let stringURL = object?.image else { return }
            guard let inageUrl = URL(string: stringURL) else { return }
            guard let imageData = try? Data(contentsOf: inageUrl) else { return }
            
            DispatchQueue.main.async {
                self.myImage.image = UIImage(data: imageData)
            }
        }
    }
}
