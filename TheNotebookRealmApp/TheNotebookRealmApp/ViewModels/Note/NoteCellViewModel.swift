//
//  NoteCellViewModel.swift
//  TheNotebookRealmApp
//
//  Created by Rodrigo  Candido on 21/2/21.
//

import Foundation

class NoteCellViewModel {
    
    private var note: Note
    
    var title:     String
    var createdAt: Date
    
    init(note: Note){
        self.note  = note
        self.title     = self.note.title
        self.createdAt = self.note.createdAt
    }
    
    func getNote() -> Note {
        return self.note
    }
}
