//
//  DetailViewController.swift
//  Ricky and Morty
//
//  Created by Денис Иванов on 22.10.2019.
//  Copyright © 2019 Денис Иванов. All rights reserved.
//

import SDWebImage

class DetailViewController: UITableViewController {
    
    @IBOutlet var cell: UITableViewCell!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var spaciesLabel: UILabel!
    @IBOutlet var gederLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var avatar: UIImageView!
    
    var сharacter: Сharacter!
    var dateFormater: DateFormaterService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormater = DateFormaterService()
        cell.separatorInset = UIEdgeInsets(top: 0, left: 1000, bottom: 0, right: 0)
        customizeTableView(object: сharacter)
    }
    
    // MARK: - Private methods
    
    private func customizeTableView(object: Сharacter) {
        title = object.name
        idLabel.text = "# \(object.id)"
        statusLabel.text = object.status.rawValue
        spaciesLabel.text = object.species.rawValue
        gederLabel.text = object.gender.rawValue
        dateLabel.text = dateFormater.creatDateString(stringJson: object.created)
        
        DispatchQueue.global().async {
            guard let inageUrl = URL(string: object.image) else { return }
            DispatchQueue.main.async {
                self.avatar.sd_setImage(with: inageUrl,
                placeholderImage: UIImage(named: "noImage"),
                options: .highPriority,
                context: nil)
            }
        }
        tableView.tableFooterView = UIView()
    }
}
