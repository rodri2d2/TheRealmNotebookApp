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
    private let dataManager = DataManager.shared
    private var noteCellViewModel: [NoteCellViewModel] = []
    
    //Delegates
    var delegate: NoteViewModelDelegate?
    
    init(belongsTo: Notebook){
        self.notebook = belongsTo
    }
    
    func viewWasLoad(){
        
        self.noteCellViewModel.removeAll()
        let notes = self.dataManager.fetchAllNotes(belongsTo: self.notebook)
        notes?.forEach({ [weak self] (note) in
            guard let self = self else {return}
            self.noteCellViewModel.append(NoteCellViewModel(note: note))
        })
    }
    
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
        let note = Note()
        note.title = title
        note.createdAt = Date()
        
        self.dataManager.addNote(note: note, belongsTo: self.notebook)
        
        self.viewWasLoad()
        self.delegate?.dataDidChange()
    }
    
    func updateButtonWasPressed(note: Note, newTitle: String){
        self.dataManager.updateNote(note: note, with: newTitle)
        self.viewWasLoad()
        self.delegate?.dataDidChange()
    }
    
    func deleteButtonWasPressed(note: Note)  {
        self.dataManager.deleteNote(note: note)
        self.viewWasLoad()
        self.delegate?.dataDidChange()
    }
    
    func statingSearchFor(text: String){
        self.noteCellViewModel.removeAll()
        let notes = self.dataManager.fetchSingleNote(searchFor: text)
        notes?.forEach({ [weak self] (note) in
            guard let self = self else {return}
            self.noteCellViewModel.append(NoteCellViewModel(note: note))
        })
        self.delegate?.dataDidChange()
    }
    
}
