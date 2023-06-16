//
//  HeadCell.swift
//  test1
//
//  Created by Dmitry  Nidzelsky  on 06.06.2023.
//

import UIKit

class HeadCell: BaseTableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func expandBtnHndlr(_ sender: UIButton) {
        parentVC?.updateCell(tag: tag)
    }
    
    
    

}
