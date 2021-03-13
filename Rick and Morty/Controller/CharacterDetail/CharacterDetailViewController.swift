//
//  CharacterDetailViewController.swift
//  Rick and Morty
//
//  Created by Денис Иванов on 22.10.2019.
//  Copyright © 2019 Денис Иванов. All rights reserved.
//

import SDWebImage

class CharacterDetailViewController: UITableViewController {
    
    @IBOutlet var cell: UITableViewCell!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var spaciesLabel: UILabel!
    @IBOutlet var gederLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var numberOfEpisodesLabel: UILabel!
    @IBOutlet var avatar: UIImageView!
    
    var сharacter: Сharacter!
    var dateFormater: DateFormaterService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormater = DateFormaterService()
        customizeTableView(object: сharacter)
    }
    
    override func viewDidLayoutSubviews() {
        cell.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width / 2, bottom: 0, right: UIScreen.main.bounds.width / 2)
    }
    
    // MARK: - Private methods
    
    private func customizeTableView(object: Сharacter) {
        title = object.name
        idLabel.text = "# \(object.id)"
        statusLabel.text = object.status.rawValue
        spaciesLabel.text = object.species.rawValue
        gederLabel.text = object.gender.rawValue
        dateLabel.text = dateFormater.creatDateString(stringJson: object.created)
        locationLabel.text = object.location.name
        numberOfEpisodesLabel.text = "\(object.episode.count)"
        
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
