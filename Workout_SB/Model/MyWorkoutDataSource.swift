//
//  SetDataSource.swift
//  Workout_SB
//
//  Created by Mark ⠀ on 6/24/21.
//
import UIKit

class MyWorkoutDataSource : NSObject, UITableViewDataSource, UISearchBarDelegate {
    ///Protocol stubs
    var collection = [MyWorkout]()
    var filteredResults = [MyWorkout]()
    var searching = false
    
    init(collection: [MyWorkout]) {
        self.collection = collection
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searching) {
            return filteredResults.count
        }
        else {
            return collection.count
        }
    }
    
    ///--

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
  
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutTableViewCell", for: indexPath) as! WorkoutTableViewCell
        
        if searching {
            cell.workoutTitleLabel.text = filteredResults[indexPath.item].name
            let numOfSets = filteredResults[indexPath.item].sets.count
            cell.numOfSetsLabel.setTitle("  \(numOfSets) sets", for: .normal)
            if (numOfSets == 1) {cell.numOfSetsLabel.setTitle("  \(numOfSets) set", for: .normal)}
            
            var numOfExercises = 0
            for s in filteredResults[indexPath.item].sets {
                numOfExercises += s.exercises.count
            }
            cell.numOfExercisesLabel.setTitle("  \(numOfExercises) exercises", for: .normal)
            if (numOfExercises == 1) {cell.numOfSetsLabel.setTitle("  \(numOfExercises) exercises", for: .normal)}
            
            var totalMinutes = 0
            var totalSeconds = 0
            for s in filteredResults[indexPath.item].sets {
                for e in s.exercises {
                    let components = e.time.split { $0 == ":" } .map { (x) -> Int in return Int(String(x))! }
            
                        totalMinutes += components[0]
                        totalSeconds += components[1]
                }
            }
            var overallSeconds = totalSeconds + (60 * totalMinutes)
            totalMinutes = overallSeconds / 60
            totalSeconds = overallSeconds % 60
            var minutesToString = String(totalMinutes)
            var secondsToString = String(totalSeconds)
            if (totalMinutes < 10) {
                minutesToString = "0\(totalMinutes)"
            }
            
            if (totalSeconds < 10) {
                secondsToString = "0\(totalSeconds)"
            }
            cell.workoutLengthLabel.setTitle("  \(minutesToString):\(secondsToString)", for: .normal)
            
        } else {
            cell.workoutTitleLabel.text = collection[indexPath.item].name
            let numOfSets = collection[indexPath.item].sets.count
            cell.numOfSetsLabel.setTitle("  \(numOfSets) sets", for: .normal)
            if (numOfSets == 1) {cell.numOfSetsLabel.setTitle("  \(numOfSets) set", for: .normal)}
            
            var numOfExercises = 0
            for s in collection[indexPath.item].sets {
                numOfExercises += s.exercises.count
            }
            cell.numOfExercisesLabel.setTitle("  \(numOfExercises) exercises", for: .normal)
            if (numOfExercises == 1) {cell.numOfExercisesLabel.setTitle("  \(numOfExercises) exercises", for: .normal)}
            
            var totalMinutes = 0
            var totalSeconds = 0
            for s in collection[indexPath.item].sets {
                for e in s.exercises {
                    let components = e.time.split { $0 == ":" } .map { (x) -> Int in return Int(String(x))! }
            
                        totalMinutes += components[0]
                        totalSeconds += components[1]
                }
            }
            var overallSeconds = totalSeconds + (60 * totalMinutes)
            totalMinutes = overallSeconds / 60
            totalSeconds = overallSeconds % 60
            var minutesToString = String(totalMinutes)
            var secondsToString = String(totalSeconds)
            if (totalMinutes < 10) {
                minutesToString = "0\(totalMinutes)"
            }
            
            if (totalSeconds < 10) {
                secondsToString = "0\(totalSeconds)"
            }
            cell.workoutLengthLabel.setTitle("  \(minutesToString):\(secondsToString)", for: .normal)
            
        }
        
        if (cell.workoutTitleLabel.text == "") {
            cell.workoutTitleLabel.text = "Unnamed Workout"
//            cell.workoutTitleLabel.textColor = .gray
        }
        
        return cell
        
        cell.workoutTitleLabel.text = collection[indexPath.item].name
        
        ///Implement logic to convert collection[].time to mm:ss format
        /// {
        ///     }
        let numOfSets = collection[indexPath.item].sets.count
        cell.numOfSetsLabel.setTitle("  \(numOfSets) sets", for: .normal)
        if (numOfSets == 1) {cell.numOfSetsLabel.setTitle("  \(numOfSets) set", for: .normal)}
        
        var numOfExercises = 0
        for s in collection[indexPath.item].sets {
            numOfExercises += s.exercises.count
        }
        cell.numOfExercisesLabel.setTitle("  \(numOfExercises) exercises", for: .normal)
        if (numOfExercises == 1) {cell.numOfSetsLabel.setTitle("  \(numOfExercises) exercises", for: .normal)}
        
        var totalMinutes = 0
        var totalSeconds = 0
        for s in collection[indexPath.item].sets {
            for e in s.exercises {
                let components = e.time.split { $0 == ":" } .map { (x) -> Int in return Int(String(x))! }
        
                    totalMinutes += components[0]
                    totalSeconds += components[1]
            }
        }
        var overallSeconds = totalSeconds + (60 * totalMinutes)
        totalMinutes = overallSeconds / 60
        totalSeconds = overallSeconds % 60
        var minutesToString = String(totalMinutes)
        var secondsToString = String(totalSeconds)
        if (totalMinutes < 10) {
            minutesToString = "0\(totalMinutes)"
        }
        
        if (totalSeconds < 10) {
            secondsToString = "0\(totalSeconds)"
        }
        cell.workoutLengthLabel.setTitle("  \(minutesToString):\(secondsToString)", for: .normal)
        
        return cell
    }

    
}

