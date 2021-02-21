//
//  NoteViewController.swift
//  TheNotebookRealmApp
//
//  Created by Rodrigo  Candido on 21/2/21.
//

import UIKit

class NoteViewController: UIViewController {
    
   // MARK: - Class properties
    private let viewModel: NoteViewModel
    
    
    // MARK: - Outlets
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource         = self
        tableView.delegate           = self
        return tableView
    }()

    
    // MARK: - Lyfecycle
    init(noteViewModel: NoteViewModel) {
        self.viewModel = noteViewModel
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
        let alert = UIAlertController(title: "Add Note", message: "Enter the title of your note", preferredStyle: .alert)
        
        alert.addTextField { (textield) in
            textield.placeholder = "Note title"
        }
        
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { (action) in

            if let noteTitle = alert.textFields?.first?.text{
                if !noteTitle.isEmpty{
                    self.viewModel.plusButtonWasPressed(title: noteTitle)
                }
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Class functionalities
    private func setupOutletsStyleAndItems(){
        setupNavigationBarStyleAndItems()
        setupTableView()
    }
    
    private func setupNavigationBarStyleAndItems(){
        //
        self.title = self.viewModel.titleWasRequested()
        
        //
        self.addPlusButton()
        
    }
    
    private func addPlusButton(){
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didPressPlusButton))
        self.navigationItem.rightBarButtonItem = plusButton
    }
    
    private func setupTableView(){
        self.tableView.register(UINib(nibName: "NoteCell", bundle: .main), forCellReuseIdentifier: NoteCell.IDENTIFIER)
        self.view.addSubview(self.tableView)
        self.tableView.pin(to: self.view)
    }
    
}

// MARK: - Extension for TableView DataSource
extension NoteViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfNotes()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellViewModel = self.viewModel.noteCellForRow(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.IDENTIFIER, for: indexPath) as! NoteCell
        cell.configure(viewModel: cellViewModel)
        return cell
    }
}

// MARK: - Extension for UITableView Delegate
extension NoteViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}



extension NoteViewController: NoteViewModelDelegate{
    func dataDidChange() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
