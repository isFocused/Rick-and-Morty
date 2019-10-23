//
//  ViewController.swift
//  Ricky and Morty
//
//  Created by Денис Иванов on 19.10.2019.
//  Copyright © 2019 Денис Иванов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var сharacters = [Сharacter]()
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activitiIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activitiIndicator.startAnimating()
        tableView.isHidden = true
        navigationController?.navigationBar.isHidden = true
        tableView.tableFooterView = UIView()
        parseJson()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if tableView.indexPathForSelectedRow != nil {
            let indexPath = tableView.indexPathForSelectedRow!
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Next" {
            let vc = segue.destination as! DetailViewController
            vc.сharacter = sender as? Сharacter
        }
    }
    
    // MARK: - Private methods
    
    private func parseJson() {
        let jsonUrlString = "https://rickandmortyapi.com/api/character/1,2,3,4,5,6,7,8,9,10,56,74,101,23,75,80,211,183"
        
        
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            do {
                self.сharacters = try JSONDecoder().decode([Сharacter].self, from: data)
                DispatchQueue.main.async {
                    self.activitiIndicator.stopAnimating()
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                    self.navigationController?.navigationBar.isHidden = false
                    self.tableView.topAnchor.constraint(equalTo:
                        self.navigationController!.navigationBar.bottomAnchor
                    ).isActive = true
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        сharacters.count
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
        let сharacter = сharacters[indexPath.row]
        
        cell.customizeCell(object: сharacter)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let сharacter = сharacters[indexPath.row]
        performSegue(withIdentifier: "Next", sender: сharacter)
    }
}
