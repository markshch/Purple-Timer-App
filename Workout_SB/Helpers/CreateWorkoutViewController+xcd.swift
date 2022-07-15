//
//  CreateWorkoutViewController+xcd.swift
//  Workout_SB
//
//  Created by Mark ⠀ on 9/9/21.
//

import UIKit
import CoreData

extension CreateWorkoutViewController {
//    func createData(){
//        
//        //As we know that container is set up in the AppDelegates so we need to refer that container.
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        
//        //We need to create a context from this container
//        let managedContext = appDelegate.persistentContainer.viewContext
//        
//        //Now let’s create an entity and new user records.
//        let userEntity = NSEntityDescription.entity(forEntityName: "myWorkout", in: managedContext)!
//        
//        //final, we need to add some data to our newly created record for each keys using
//        //here adding 5 data with loop
//        
//        var rangeArrays: [Range] = []
//        
//        for i in 1...5 {
//            let mRange = Range(location: i, length: i+1)
//            rangeArrays.append(mRange)
//        }
//        
//        let cmsg = NSManagedObject(entity: userEntity, insertInto: managedContext) as! CrewMessage
//        let mRanges = Ranges(ranges: rangeArrays)
//        cmsg.setValue(mRanges, forKeyPath: "range")
//        
//        //Now we have set all the values. The next step is to save them inside the Core Data
//        
//        cmsg.highlighted = ["one", "two", "three"]
//        cmsg.highlightedRanges = [NSRange(location: 0, length: 2), NSRange(location: 6, length: 8)]
//        
//        do {
//            try managedContext.save()
//            
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//        }
//    }

}
