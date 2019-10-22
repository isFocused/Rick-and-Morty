//
//  DetailViewController.swift
//  Ricky and Morty
//
//  Created by Денис Иванов on 22.10.2019.
//  Copyright © 2019 Денис Иванов. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {

    @IBOutlet var cell: UITableViewCell!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var spaciesLabel: UILabel!
    @IBOutlet var gederLabel: UILabel!
    @IBOutlet var avatar: UIImageView!

    var сharacter: Сharacter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cell.separatorInset = UIEdgeInsets(top: 0, left: 1000, bottom: 0, right: 0)
        
        customizeTableView(object: сharacter)
    }
    
    private func customizeTableView(object: Сharacter) {
        title = object.name
        idLabel.text = "# \(object.id ?? 0)"
        statusLabel.text = object.status.rawValue
        spaciesLabel.text = object.species.rawValue
        gederLabel.text = object.gender.rawValue
        
        DispatchQueue.global().async {
            guard let stringURL = object.image else { return }
            guard let inageUrl = URL(string: stringURL) else { return }
            guard let imageData = try? Data(contentsOf: inageUrl) else { return }
            
            DispatchQueue.main.async {
                self.avatar.image = UIImage(data: imageData)
            }
        }
        tableView.tableFooterView = UIView()
    }
}
