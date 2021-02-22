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
    
    private var searchBar = UISearchBar()

    
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
    
    @objc private func didStartSearching(){
        setupSearchBarShow(isShowing: true)
        self.searchBar.becomeFirstResponder()
    }
    
    
    private func editAction(at indexPath: IndexPath) -> UIContextualAction {
        
        let action = UIContextualAction(style: .normal, title: "Edit") { [weak self](action, view, completion) in
            guard let self = self else { return }
            
            let note = self.viewModel.noteCellForRow(at: indexPath).getNote()
            
            let alert = UIAlertController(title: "Edit Note", message: "Enter the title of your note", preferredStyle: .alert)
            
            alert.addTextField { (textield) in
                textield.text = note.title
            }
            
            alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { (action) in

                if let noteTitle = alert.textFields?.first?.text{
                    if !noteTitle.isEmpty{
                        self.viewModel.updateButtonWasPressed(note: note, newTitle: noteTitle)
                    }
                }
                
            }))
            
            //
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                
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
        
            let alert = UIAlertController(title: "Delete Note", message: "Note will be permanently deleted!", preferredStyle: .alert)
            let note = self.viewModel.noteCellForRow(at: indexPath).getNote()
    
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in

                self.viewModel.deleteButtonWasPressed(note: note)
                
            }))
            
            //
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                
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
        setupNavigationBarStyleAndItems()
        setupTableView()
    }
    
    private func setupNavigationBarStyleAndItems(){
        //
        self.title = self.viewModel.titleWasRequested()
        
        //
//        self.addPlusButton()
        self.setupSearchBar()
        self.setupSearchBarShow(isShowing: false)
        
    }
    
    private func addPlusButton(){
        
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didPressPlusButton))
        self.navigationItem.rightBarButtonItem = plusButton
    }
    
    private func setupSearchBar(){
        self.searchBar.sizeToFit()
        self.searchBar.delegate          = self
        self.searchBar.showsCancelButton = true
    }
    
    private func setupSearchBarShow(isShowing: Bool){
        
        if isShowing{
            self.navigationItem.rightBarButtonItems = nil

        }else{
            self.setupRightBarStyleAndItems()
        }
        
        self.navigationItem.titleView = isShowing ? self.searchBar : nil
        self.navigationItem.setHidesBackButton(isShowing, animated: true)
        
    }
    
        private func setupRightBarStyleAndItems(){
    
            //Add note button
            let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didPressPlusButton))

            //Search button
            let searchImage = UIImage(systemName: "magnifyingglass.circle")
            let searchButtonRightItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(didStartSearching))
    
            //Install buttons
            self.navigationItem.rightBarButtonItems = [plusButton, searchButtonRightItem]
    
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
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = editAction(at: indexPath)
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete, edit])
        
    }
    
}

extension NoteViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty{
            self.viewModel.statingSearchFor(text: searchText)
        }else{
            self.viewModel.viewWasLoad()
            self.tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.setupSearchBarShow(isShowing: false)
        self.viewModel.viewWasLoad()
        self.tableView.reloadData()
    }
}

extension NoteViewController: NoteViewModelDelegate{
    func dataDidChange() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
