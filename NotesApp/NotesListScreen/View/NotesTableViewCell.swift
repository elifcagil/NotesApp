//
//  NotesEditorTableViewCell.swift
//  NotesApp
//
//  Created by ELİF ÇAĞIL on 17.04.2025.
//

import UIKit

class NotesTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var notesTitle: UILabel!
    
    
    @IBOutlet weak var NotesSubtitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
