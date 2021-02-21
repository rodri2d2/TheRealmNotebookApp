//
//  NotebookViewController.swift
//  TheNotebookRealmApp
//
//  Created by Rodrigo  Candido on 21/2/21.
//

import UIKit

class NotebookViewController: UIViewController {

    // MARK: - Class propertities
    private var viewModel: NotebookViewModel
    
    // MARK: - Outlets
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource         = self
        tableView.delegate           = self
        return tableView
    }()
    
    
    // MARK: - Lyfecycle
    init(notebookViewModel: NotebookViewModel) {
        self.viewModel = notebookViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.viewWasLoad()
        //
        setupOutletsStyleAndItems()
    }
    
    
    // MARK: - Actions
    @objc private func didPressPlusButton(){
        
        //
        let alert = UIAlertController(title: "Add Notebook", message: "Enter the title of your new notebook", preferredStyle: .alert)
        
        alert.addTextField { (textield) in
            textield.placeholder = "Notebook title"
        }
        
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { (action) in

            if let notebookTitle = alert.textFields?.first?.text{
                if !notebookTitle.isEmpty{
                    self.viewModel.addNoteButtonWasPressed(title: notebookTitle)
                }
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Class functionalities
    private func setupOutletsStyleAndItems(){
        
        setupTableView()
        setupNavigationBar()
        
    }
    
    private func setupNavigationBar(){
        
        //Navigation bar itself congifuration
        self.title = "Notebook"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        //
        addPlusButton()
        
    }
    
    private func setupTableView(){
        self.tableView.register(UINib(nibName: "NotebookCell", bundle: .main), forCellReuseIdentifier: NotebookCell.IDENTIFIER)
        self.view.addSubview(self.tableView)
        self.tableView.pin(to: self.view)
    }
    
    private func addPlusButton(){
        
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didPressPlusButton))
        self.navigationItem.rightBarButtonItem = plusButton
    }

}

// MARK: - Extension for TableView DataSource
extension NotebookViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfNotebooks()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellViewModel = self.viewModel.notebookCellForRow(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: NotebookCell.IDENTIFIER, for: indexPath) as! NotebookCell
        cell.configure(cellViewModel: cellViewModel)
        return cell
    }
}

// MARK: - Extension for UITableView Delegate
extension NotebookViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.viewModel.notebookWasSelected(at: indexPath)
    }
}


// MARK: - Extension for
extension NotebookViewController: NotebookViewModelDelegate{
    func dataDidChange() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
