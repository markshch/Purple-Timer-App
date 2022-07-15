//
//  WorkoutTableViewCell.swift
//  Workout_SB
//
//  Created by Mark ⠀ on 6/14/21.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {
    
    
    @IBOutlet var workoutTitleLabel: UILabel!   ///OLD  PENDING DELETE
    @IBOutlet var timeToWorkoutLabel: UILabel!  ///OLD  PENDING DELETE
    
    @IBOutlet var numOfSetsLabel: UIButton!
    @IBOutlet var numOfExercisesLabel: UIButton!
    @IBOutlet var workoutLengthLabel: UIButton!
    
    
    @IBOutlet var editButton: UIButton!
    @IBOutlet var goButton: UIButton!
    
    
    override func layoutSubviews() {
         super.layoutSubviews()
         
         let bottomSpace: CGFloat = 4.0 // Let's assume the space you want is 10
         self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: bottomSpace, left: 0, bottom: bottomSpace, right: 0))
         contentView.layer.cornerRadius = 30
        
        
        editButton.layer.cornerRadius = 18
        goButton.layer.cornerRadius = 18
        
        numOfSetsLabel.imageView?.tintColor = .systemGray
        numOfExercisesLabel.imageView?.tintColor = .systemGray
        workoutLengthLabel.imageView?.tintColor = .systemGray
        
//        self.backgroundColor = .clear // very important
//        self.layer.masksToBounds = false
//        self.layer.shadowOpacity = 0.23
//        self.layer.shadowRadius = 4
//        self.layer.shadowOffset = CGSize(width: 0, height: 0)
//        self.layer.shadowColor = UIColor.black.cgColor
//
//        // add corner radius on `contentView`
////        contentView.backgroundColor = .white
//        contentView.layer.cornerRadius = 30
//        
//        self.contentView.layer.masksToBounds = true
//        
//        let radius = contentView.layer.cornerRadius
//        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        
    }

}





///Leftovers
//override func awakeFromNib() {
//    super.awakeFromNib()
//    // Initialization code
//}
//
//override func setSelected(_ selected: Bool, animated: Bool) {
//    super.setSelected(selected, animated: animated)
//
//    // Configure the view for the selected state
//}
