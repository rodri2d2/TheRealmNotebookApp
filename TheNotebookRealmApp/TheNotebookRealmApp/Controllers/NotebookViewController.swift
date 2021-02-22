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
                    self.viewModel.addNotebookButtonWasPressed(title: notebookTitle)
                }
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    private func editAction(at indexPath: IndexPath) -> UIContextualAction {
        
        let action = UIContextualAction(style: .normal, title: "Edit") { [weak self](action, view, completion) in
            guard let self = self else { return }
            
            let notebook = self.viewModel.notebookCellForRow(at: indexPath).getNotebook()
            
            let alert = UIAlertController(title: "Edit Notebook", message: "Enter the title of your new notebook", preferredStyle: .alert)
            
            alert.addTextField { (textield) in
                textield.text = notebook.title
            }
            
            alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { (action) in

                if let notebookTitle = alert.textFields?.first?.text{
                    if !notebookTitle.isEmpty{
                        self.viewModel.updateNotebookWasPressed(notebook: notebook, newTitle: notebookTitle)
                    }
                }
                
            }))
            
            //
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                self.viewModel.cancelButtonWasPressed()
            }))
            
            //
            self.present(alert, animated: true, completion: nil)
            
            
        }
        
        action.backgroundColor = .systemBlue
        action.image = UIImage(systemName: "pencil")
        return action
        
    }
    
    
    private func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        
        let action = UIContextualAction(style: .normal, title: "Edit") { [weak self](action, view, completion) in
            guard let self = self else { return }
        
            let alert = UIAlertController(title: "Delete Notebook", message: "Notebook will be permanently deleted!", preferredStyle: .alert)
            let notebook = self.viewModel.notebookCellForRow(at: indexPath).getNotebook()
    
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in

                self.viewModel.deleteButtonWasPressed(notebook: notebook)
                
            }))
            
            //
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                self.viewModel.cancelButtonWasPressed()
            }))
            
            //
            self.present(alert, animated: true, completion: nil)
            
            
        }
        
        action.backgroundColor = .systemRed
        action.image = UIImage(systemName: "trash")
        return action
        
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = deleteAction(at: indexPath)
        let edit = editAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete, edit])
        
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
