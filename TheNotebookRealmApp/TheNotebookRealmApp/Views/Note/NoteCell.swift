//
//  NoteCell.swift
//  TheNotebookRealmApp
//
//  Created by Rodrigo  Candido on 21/2/21.
//

import UIKit

class NoteCell: UITableViewCell {
    
    // MARK: - Class properties
    static let IDENTIFIER = NoteCell.description()
    
    // MARK: -Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var createdAtLabel: UILabel!
    
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        self.titleLabel.text     = nil
        self.createdAtLabel.text = nil
    }
    
    // MARK: - Class functionalities
    func configure(viewModel: NoteCellViewModel){
        self.titleLabel.text     = viewModel.title
        self.createdAtLabel.text = dateFromString(date: viewModel.createdAt)
    }
    
    private func dateFromString(date: Date) -> String{
        
        let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
        let stringDate = formatter.string(from: date)
        
        return stringDate
    }
}
