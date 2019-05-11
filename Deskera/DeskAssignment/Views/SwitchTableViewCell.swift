//
//  SwitchTableViewCell.swift
//  DeskAssignment
//
//  Created by Rahul Mahajan on 29/03/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

protocol SwitchTableCellDelegate : class{
    func switchTappedOnCell(cell : SwitchTableViewCell)
}

class SwitchTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var `switch`: UISwitch!
    
    weak var delegate : SwitchTableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func switchTapped(_ sender: UISwitch) {
        delegate?.switchTappedOnCell(cell: self)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
