//
//  Exercise.swift
//  Workout_SB
//
//  Created by Mark ⠀ on 6/23/21.
//

import UIKit

public class Exercise: NSObject, NSCoding {
    public var name: String = ""
    public var time: String = ""
    
    enum Key:String {
        case name = "name"
        case time = "time"
    }
    
    init(name: String, time: String) {
        self.name = name
        self.time = time
    }
    
    
    public override init() {
        super.init()
    }
    
    public func encode(with aCoder: NSCoder) {
        
        aCoder.encode(name, forKey: Key.name.rawValue)
        aCoder.encode(time, forKey: Key.time.rawValue)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        
        let mname = aDecoder.decodeObject(forKey: "name") as! String
        let mtime = aDecoder.decodeObject(forKey: "time") as! String
        
        self.init(name: String(mname), time: String(mtime))
    }
}
