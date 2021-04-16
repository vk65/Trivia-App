//
//  TableViewCell.swift
//  Trivia App
//
//  Created by Cheripelly tirumala on 16/04/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var resultLbl: UILabel!
    
    @IBOutlet weak var nameResLbl: UILabel!
    
    @IBOutlet weak var dateLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        resultLbl.numberOfLines = 0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
