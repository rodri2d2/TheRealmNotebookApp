//
//  Note.swift
//  TheNotebookRealmApp
//
//  Created by Rodrigo  Candido on 21/2/21.
//

import Foundation
import RealmSwift

class Note: Object{
    
    @objc dynamic var title =      ""
    @objc dynamic var createdAt = Date()

}
