//
//  NotebookCellViewModel.swift
//  TheNotebookRealmApp
//
//  Created by Rodrigo  Candido on 21/2/21.
//

import Foundation
class NotebookCellViewModel {
    
    private var notebook: Notebook
    
    var title:     String
    var createdAt: Date
    
    init(notebook: Notebook){
        self.notebook  = notebook
        self.title     = self.notebook.title
        self.createdAt = self.notebook.createdAt
    }
    
    
    func getNotebook() -> Notebook {
        return self.notebook
    }
}
