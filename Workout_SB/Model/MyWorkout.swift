

//
//  Set.swift
//  Workout_SB
//
//  Created by Mark ⠀ on 6/24/21.
//

import Foundation

///Named "MySet" to avoid conflict with "Set"

public class MyWorkout: NSObject, NSCoding {
    
    public var name: String = ""
    public var totalTime: Double = 0
    public var sets: [SetWithExercises] = []
    
    enum Key:String {
        case name = "name"
        case totalTime = "totalTime"
        case sets = "sets"
    }
    
    init(name: String, totalTime: Double, sets: [SetWithExercises]) {
        self.name = name
        self.totalTime = totalTime
        self.sets = sets
    }
    
    public override init() {
        super.init()
    }
    
    public func encode(with aCoder: NSCoder) {
        
        aCoder.encode(name, forKey: Key.name.rawValue)
        aCoder.encode(totalTime, forKey: Key.totalTime.rawValue)
        aCoder.encode(sets, forKey: Key.sets.rawValue)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        
        let mname = aDecoder.decodeObject(forKey: "name") as! String
        let mtotalTime = aDecoder.decodeDouble(forKey: "totalTime")
        let msets = aDecoder.decodeObject(forKey: "sets") as! [SetWithExercises]

        self.init(name: String(mname), totalTime: Double(mtotalTime), sets: [SetWithExercises](msets))
    }
//
//    public func encode(with coder: NSCoder) {
//        coder.encode(name, forKey: "name")
//        coder.encode(totalTime, forKey: "totalTime")
//        coder.encode(sets, forKey: "sets")
//    }
//
//    required public init?(coder: NSCoder) {
//        self.name = coder.decodeObject(forKey: "name") as! String
//        self.totalTime = coder.decodeDouble(forKey: "totalTime")
//        self.sets = coder.decodeObject(forKey:"sets") as! [SetWithExercises]?
//    }
//
//    override init() {
//        super.init() // This got rid of the "Missing argument for parameter 'coder' in call.
//    }



}

