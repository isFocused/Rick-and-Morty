//
//  ViewController.swift
//  Ricky and Morty
//
//  Created by Денис Иванов on 19.10.2019.
//  Copyright © 2019 Денис Иванов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var сharacters: [Сharacter]?
    let networkManager = NetworkService()
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activitiIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activitiIndicator.startAnimating()
        tableView.isHidden = true
        navigationController?.navigationBar.isHidden = true
        tableView.tableFooterView = UIView()
        networkManager.getData { self.сharacters = $0; self.updateInterfeise() }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Next" {
            let vc = segue.destination as! DetailViewController
            vc.сharacter = sender as? Сharacter
        }
    }
    
    // MARK: - Private methods
    
    func updateInterfeise() {
        DispatchQueue.main.async {
            self.activitiIndicator.stopAnimating()
            self.tableView.isHidden = false
            self.tableView.reloadData()
            self.navigationController?.navigationBar.isHidden = false
            self.tableView.setNeedsUpdateConstraints()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        сharacters?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        cell.myImage.image = nil
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        cell.myImage.image = nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        let сharacter = сharacters?[indexPath.row]
        
        cell.customizeCell(object: сharacter)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let сharacter = сharacters?[indexPath.row]
        performSegue(withIdentifier: "Next", sender: сharacter)
    }
}
