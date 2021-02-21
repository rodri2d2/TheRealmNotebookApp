//
//  NotebookViewModel.swift
//  TheNotebookRealmApp
//
//  Created by Rodrigo  Candido on 21/2/21.
//

import Foundation
class NotebookViewModel {
    
    // MARK: - Class properties
    //Delegate
    var delegate:            NotebookViewModelDelegate?
    var coordinatorDelegate: NotebookCoordinatorDelegate?
    
    //Data
    private var notebookCellViewModel: [NotebookCellViewModel] = []
    private let dataManager = DataManager.shared
    
    
    // MARK: - Class functionalities
    func viewWasLoad(){
        
        self.notebookCellViewModel.removeAll()
        let notebooks = self.dataManager.fetchAllNotebooks()
        notebooks?.forEach({ [weak self] (notebook) in
            guard let self = self else {return}
            self.notebookCellViewModel.append(NotebookCellViewModel(notebook: notebook))
        })
    }
    
    func numberOfNotebooks() -> Int {
        return notebookCellViewModel.count
    }
    
    func notebookCellForRow(at indexPath: IndexPath) -> NotebookCellViewModel {
        return notebookCellViewModel[indexPath.row]
    }
    
    func addNoteButtonWasPressed(title: String){
        let notebook = Notebook()
        notebook.createdAt = Date()
        notebook.title = title
        
        self.dataManager.addNoteBook(notebook: notebook)
        self.viewWasLoad()
        self.delegate?.dataDidChange()
    }
    
    func notebookWasSelected(at indexPath: IndexPath){
        let notebook = notebookCellViewModel[indexPath.row].getNotebook()
        self.coordinatorDelegate?.didSelectANotebook(notebook: notebook)
    }
}
