//
//  MyCell.swift
//  TaskAppV2
//
//  Created by Ryan Rudzitis on 2015-05-20.
//  Copyright (c) 2015 Ryan Rudzitis. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var textField: UITextField!
    override func didTransitionToState(state: UITableViewCellStateMask) {
        let editing = UITableViewCellStateMask.ShowingEditControlMask.rawValue
        
        if state.rawValue & editing != 0 {
            self.textField.enabled = true
        } else {
            self.textField.enabled = false
        }
    }
    
}
