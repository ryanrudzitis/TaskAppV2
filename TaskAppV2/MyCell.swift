//
//  MyCell.swift
//  TaskAppV2
//
//  Created by Ryan Rudzitis on 2015-05-20.
//  Copyright (c) 2015 Ryan Rudzitis. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {
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
