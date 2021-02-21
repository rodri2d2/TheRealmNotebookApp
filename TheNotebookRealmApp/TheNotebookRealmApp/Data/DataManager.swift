//
//  DataManager.swift
//  TheNotebookRealmApp
//
//  Created by Rodrigo  Candido on 21/2/21.
//

import Foundation
import RealmSwift

class DataManager: NSObject{
    
    static let shared = DataManager()
    private var realm: Realm
    
    private override init() {
        self.realm = try! Realm()
        super.init()
    }    
}

// MARK: - Extension for Notebook Mangement
extension DataManager{
    
    func fetchAllNotebooks() -> [Notebook]? {
        
        let notebooks = realm.objects(Notebook.self)
        return notebooks.map { (notebooks) in
            notebooks
        }
        
    }
    
    func addNoteBook(notebook: Notebook){
        do {
            try realm.write({
                realm.add(notebook)
            })
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    func updateNotebook(notebook: Notebook, with newTitle: String){
        do {
            try realm.write({
                notebook.title = newTitle
            })
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    func deleteNotebook(notebook: Notebook){
        do {
            try realm.write {
                realm.delete(notebook)
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
}

// MARK: - Extension for Note
extension DataManager {

  
    func fetchAllNotes(belongsTo: Notebook) -> [Note]?{
        let notes = belongsTo.notes
        return notes.map { (notes) in
            notes
        }
    }
    
    func addNote(note: Note, belongsTo notebook: Notebook){
        do {
            try realm.write({
                notebook.notes.append(note)
            })
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    func updateNote(note: Note, with newTitle: String){
        do {
            try realm.write {
                note.title = newTitle
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func deleteNote(note: Note){
        
        do {
            try realm.write {
                realm.delete(note)
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
}
