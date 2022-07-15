//
//  MyWorkouts.swift
//  Workout_SB
//
//  Created by Mark ⠀ on 9/19/21.
//

import Foundation

public class MyWorkouts: NSObject, NSCoding {
    public var workouts: [MyWorkout] = []
    
    enum Key:String {
        case workouts = "workouts"
    }
    
    init(workouts: [MyWorkout]) {
        self.workouts = workouts
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(workouts, forKey: Key.workouts.rawValue)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        let mWorkouts = aDecoder.decodeObject(forKey: Key.workouts.rawValue) as! [MyWorkout]
        self.init(workouts: mWorkouts)
    }
}
