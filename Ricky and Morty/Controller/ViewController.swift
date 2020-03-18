//
//  ViewController.swift
//  Ricky and Morty
//
//  Created by Денис Иванов on 19.10.2019.
//  Copyright © 2019 Денис Иванов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var сharacters: [Сharacter]!
    let networkManager = NetworkService()
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Конец таблицы"
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return label
    }()
    
     let myView: UIView = {
        UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
    }()

    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activitiIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activitiIndicator.startAnimating()
        tableView.isHidden = true
        tableView.tableFooterView = myView
        navigationController?.navigationBar.isHidden = true
        networkManager.getData { [weak self] in
            switch $0 {
            case .success(let сharacters):
                self?.сharacters = сharacters
                self?.updateInterfeise()
            case .failure(let error):
                self?.errorAlert(message: error.localizedDescription)
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Next" {
            let viewController = segue.destination as! DetailViewController
            viewController.сharacter = sender as? Сharacter
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
    
    func errorAlert(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error",
                                          message: message,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alert, animated: true)
        }
    }
    
    func layout() {
        myView.addSubview(label)
        label.centerXAnchor.constraint(equalTo: myView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: myView.centerYAnchor).isActive = true
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        сharacters?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == сharacters.count - 1 {
            networkManager.getData { [weak self] in
                guard let self = self else { return }
                switch $0 {
                case .success(let newCharacters):
                    newCharacters?.forEach {
                        self.сharacters.insert($0, at: self.сharacters.endIndex)
                        self.tableView.insertRows(at: [IndexPath(row: self.сharacters.count - 1, section: 0)], with: .automatic)
                    }
                case .failure(let error):
                    self.errorAlert(message: error.localizedDescription)
                }
            }
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        let сharacter = сharacters?[indexPath.row]
        
        cell.сonfigureСell(object: сharacter)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let сharacter = сharacters?[indexPath.row]
        performSegue(withIdentifier: "Next", sender: сharacter)
    }
}
