//
//  NotebookCell.swift
//  TheNotebookRealmApp
//
//  Created by Rodrigo  Candido on 21/2/21.
//

import UIKit

class NotebookCell: UITableViewCell {
    
    // MARK: - Class properties
    static let IDENTIFIER = NotebookCell.description()
    
    // MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func prepareForReuse() {
        self.titleLabel.text = nil
        self.dateLabel.text  = nil
    }
    
    func configure(cellViewModel: NotebookCellViewModel){
        self.titleLabel.text = cellViewModel.title
        self.dateLabel.text  = self.dateFromString(date: cellViewModel.createdAt)
    }
    
    private func dateFromString(date: Date) -> String{
        let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
        let stringDate = formatter.string(from: date)
        
        return stringDate
    }
    
    
}
