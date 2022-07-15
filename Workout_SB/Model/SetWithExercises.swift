//
//  SetWithExercises.swift
//  Workout_SB
//
//  Created by Mark ⠀ on 6/24/21.
//

import Foundation

public class SetWithExercises: NSObject, NSCoding {
    public var exercises: [Exercise] = []
    
    enum Key:String {
        case exercises = "exercises"
    }
    
    init(exercises: [Exercise]) {
        self.exercises = exercises
    }
    
    public override init() {
        super.init()
    }
    
    public func encode(with aCoder: NSCoder) {
        
        aCoder.encode(exercises, forKey: Key.exercises.rawValue)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        
        let mexercises = aDecoder.decodeObject(forKey: "exercises") as! [Exercise]
        
        self.init(exercises: mexercises)
    }
}
