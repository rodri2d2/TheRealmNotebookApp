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
    var delegate: NotebookViewModelDelegate?
    
    //Data
    private var notebookCell: [NotebookCellViewModel] = []
    
    
    // MARK: - Class functionalities
    func viewWasLoad(){}
    
    func numberOfNotebooks() -> Int {
        return notebookCell.count
    }
    
    func noteboolCellForRow(at indexPath: IndexPath) -> NotebookCellViewModel {
        return notebookCell[indexPath.row]
    }
    
    func addNoteButtonWasPressed(title: String){
        let notebook = Notebook(title: title, createdAt: Date())
        notebookCell.append(NotebookCellViewModel(notebook: notebook))
        self.delegate?.dataDidChange()
    }
}
