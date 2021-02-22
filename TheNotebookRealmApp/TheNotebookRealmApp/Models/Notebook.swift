//
//  Notebook.swift
//  TheNotebookRealmApp
//
//  Created by Rodrigo  Candido on 21/2/21.
//

import Foundation
import RealmSwift

class Notebook: Object{
    
    @objc dynamic var title =    ""
    @objc dynamic var createdAt = Date()
    
    //Has many notes
    let notes = List<Note>()
}
