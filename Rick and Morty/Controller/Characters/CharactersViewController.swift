//
//  CharactersViewController.swift
//  Rick and Morty
//
//  Created by Денис Иванов on 19.10.2019.
//  Copyright © 2019 Денис Иванов. All rights reserved.
//

import UIKit

class CharactersViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Private properties
    
    private var сharacters: [Сharacter]!
    private let networkManager = NetworkService()
    private let segueIdentifaer: SegueIdentifaer = .detail
    private var carentPage = 1
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confugureScreen()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifaer.rawValue {
            let viewController = segue.destination as! CharacterDetailViewController
            viewController.сharacter = sender as? Сharacter
        }
    }
    
    // MARK: - Configuration
    
    private func confugureScreen() {
        confugureiOSVersion()
        activityIndicator.startAnimating()
        tableView.isHidden = true
        navigationController?.navigationBar.isHidden = true
        loadData()
    }
    
    private func confugureiOSVersion() {
        if #available(iOS 13.0, *) {
            activityIndicator.style = .large
        } else {
            activityIndicator.style = .whiteLarge
        }
    }
    
    // MARK: - Private methods
    
    private func updateInterfeise() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.tableView.isHidden = false
            self.tableView.reloadData()
            self.navigationController?.navigationBar.isHidden = false
            self.tableView.setNeedsUpdateConstraints()
        }
    }
    
    private func errorAlert(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error",
                                          message: message,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alert, animated: true)
        }
    }
    
    private func loadData() {
        networkManager
            .loadData(target: .character(carentPage), type: JSONData.self) { [weak self] in
                switch $0 {
                case let .success(json):
                    self?.carentPage += 1
                    self?.сharacters = json.results
                    self?.updateInterfeise()
                case let .failure(error):
                    self?.errorAlert(message: error.localizedDescription)
                }
        }
    }
    
    private func loadNextPage() {
        networkManager.loadData(target: .character(carentPage), type: JSONData.self) { [weak self] in
            switch $0 {
            case let .success(json):
                guard json.info.pages != self?.carentPage else { return }
                self?.carentPage += 1
                self?.сharacters.append(contentsOf: json.results)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case let .failure(error):
                self?.errorAlert(message: error.localizedDescription)
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CharactersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        сharacters?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterViewCell.reuseIdentifaer, for: indexPath) as! CharacterViewCell
        let сharacter = сharacters?[indexPath.row]
        cell.сonfigureСell(object: сharacter)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let сharacter = сharacters?[indexPath.row]
        performSegue(withIdentifier: segueIdentifaer.rawValue, sender: сharacter)
    }
}

extension CharactersViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach {
            if $0.row == self.сharacters.count - 1 {
                self.loadNextPage()
            }
        }
    }
}
