//
//  NotebookViewController.swift
//  TheNotebookRealmApp
//
//  Created by Rodrigo  Candido on 21/2/21.
//

import UIKit

class NotebookViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .orange
    }

}

// MARK: - Extension for TableView DataSource
extension NotebookViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Cell \(indexPath.row)"
        return cell
    }
}

// MARK: - Extension for UITableView Delegate
extension NotebookViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
