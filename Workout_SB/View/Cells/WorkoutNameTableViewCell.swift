//
//  WorkoutNameTableViewCell.swift
//  Workout_SB
//
//  Created by Mark ⠀ on 6/18/21.
//

import UIKit

class WorkoutNameTableViewCell: UITableViewCell {
    
    @IBOutlet var workoutName: UITextField!
    
    
    @IBAction func saveWorkoutName(_ sender: UITextField) {
        let s = superview as! UITableView
        let a = s.dataSource as! SetWithExercisesDataSource
        a.workoutName = sender.text ?? "Workout"
        


    }
    
    override class func awakeFromNib() {
        
    }
    
    
    



}
