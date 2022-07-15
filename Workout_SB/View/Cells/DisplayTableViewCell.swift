//
//  DisplayTableViewCell.swift
//  Workout_SB
//
//  Created by Mark ⠀ on 8/7/21.
//

import UIKit

class DisplayTableViewCell: UITableViewCell {
    
    @IBOutlet var shadowView: ShadowView!
    @IBOutlet var mainView: UIView!
    @IBOutlet var exerciseTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        mainView.layer.cornerRadius = 20
        mainView.layer.masksToBounds = true
        mainView.layer.borderWidth = 1
        mainView.layer.borderColor = UIColor.clear.cgColor
        dynamicBackgroundColor()



    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        dynamicBackgroundColor()

        super.traitCollectionDidChange(previousTraitCollection)
    }
    
    func dynamicBackgroundColor() {
        switch traitCollection.userInterfaceStyle {
            case .light, .unspecified:
                mainView.layer.borderColor = UIColor.clear.cgColor
                mainView.backgroundColor = .white
            case .dark:
//                mainView.layer.borderColor = UIColor.blue.cgColor
                mainView.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.10, alpha: 0.85) /* #0c0c0c */
                mainView.layer.borderColor = UIColor.clear.cgColor
//                mainView.layer.opacity = 0.2
        @unknown default:
            self.layer.shadowColor = UIColor.blue.cgColor
            
        }
    }


}
