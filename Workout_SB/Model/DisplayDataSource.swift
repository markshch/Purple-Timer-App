//
//  DisplayDataSource.swift
//  Workout_SB
//
//  Created by Mark ⠀ on 8/7/21.
//

import UIKit

class DisplayDataSource : NSObject, UITableViewDataSource {
    var collection: [Exercise]
    
    init(using collection: [Exercise]) {
        self.collection = collection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        collection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DisplayTableViewCell", for: indexPath) as! DisplayTableViewCell
        cell.exerciseTitle.text = collection[indexPath.row].name
        cell.layer.cornerRadius = 9
        if (indexPath.row > 2) {
            cell.contentView.alpha = 0.0
            
        }
        return cell
    }
    
    
}
