//
//  Note.swift
//  TheNotebookRealmApp
//
//  Created by Rodrigo  Candido on 21/2/21.
//

import Foundation

class NoteViewModel{
    
    // MARK: - Class properties
    private let notebook: Notebook
    
    //Data
    private var noteCellViewModel: [NoteCellViewModel] = []
    
    //Delegates
    var delegate: NoteViewModelDelegate?
    
    init(belongsTo: Notebook){
        self.notebook = belongsTo
    }
    
    func viewWasLoad(){}
    
    func titleWasRequested() -> String {
        return notebook.title
    }
    
    func noteCellForRow(at indexPath: IndexPath) -> NoteCellViewModel{
        return noteCellViewModel[indexPath.row]
    }
    
    func numberOfNotes() -> Int{
        return noteCellViewModel.count
    }
    
    func plusButtonWasPressed(title: String){
        let note = Note(title: title, createdAt: Date())
        self.noteCellViewModel.append(NoteCellViewModel(note: note))
        delegate?.dataDidChange()
    }
    
}
