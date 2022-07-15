//
//  NewSetTableViewCell.swift
//  Workout_SB
//
//  Created by Mark ⠀ on 6/18/21.
//

import UIKit

class NewSetTableViewCell: UITableViewCell {
    
    @IBOutlet var newSetButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        newSetButton.layer.cornerRadius = 9
        newSetButton.layer.backgroundColor = UIColor.systemGray6.cgColor
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        newSetButton.layer.backgroundColor = UIColor.systemGray6.cgColor
        newSetButton.setNeedsDisplay()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
