//
//  ExpandedCell.swift
//  test1
//
//  Created by Dmitry  Nidzelsky  on 06.06.2023.
//

import UIKit

class ExpandedCell: BaseTableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var rnbGameNameLabel: UILabel!
    @IBOutlet weak var crossAndNillGameNameLabel: UILabel!
    @IBOutlet weak var hiddenButtonGameNameLabel: UILabel!
    
    @IBOutlet weak var rnbScoreLabel: UILabel!
    @IBOutlet weak var crossAndNillScoreLabel: UILabel!
    @IBOutlet weak var hiddenButtonScoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func collapsedBtnHndlr(_ sender: UIButton) {
        parentVC?.updateCell(tag: tag)
    }
    
    
    
    
    

}
