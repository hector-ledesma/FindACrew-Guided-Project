//
//  PersonSearchTableViewController.swift
//  FindACrew
//
//  Created by Karen Rodriguez on 3/10/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit

class PersonSearchTableViewController: UITableViewController {

    // MARK: - Properties
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let personController = PersonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return personController.people.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as? PersonTableViewCell else { return UITableViewCell() }

        // Configure the cell...
        let person = personController.people[indexPath.row]
        cell.person = person
        
        return cell
    }
}
            
extension PersonSearchTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        personController.searchForPeopleWith(searchTerm: searchTerm) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
