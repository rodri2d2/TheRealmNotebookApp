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
    
    
    // MARK: - Class functionalities
    func viewWasLoad(){}
    
    func numberOfNotebooks() -> Int {
        return notebookCellViewModel.count
    }
    
    func notebookCellForRow(at indexPath: IndexPath) -> NotebookCellViewModel {
        return notebookCellViewModel[indexPath.row]
    }
    
    func addNoteButtonWasPressed(title: String){
        let notebook = Notebook(title: title, createdAt: Date())
        notebookCellViewModel.append(NotebookCellViewModel(notebook: notebook))
        self.delegate?.dataDidChange()
    }
    
    func notebookWasSelected(at indexPath: IndexPath){
        let notebook = notebookCellViewModel[indexPath.row].getNotebook()
        self.coordinatorDelegate?.didSelectANotebook(notebook: notebook)
    }
}
