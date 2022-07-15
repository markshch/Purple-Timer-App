//
//  WorkoutsTableView.swift
//  Workout_SB
//
//  Created by Mark ⠀ on 10/12/21.
//

import UIKit

class WorkoutsTableView: UITableView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension WorkoutsTableView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var ds = self.dataSource as! MyWorkoutDataSource
        ViewController().filteredResults = ds.collection.filter { $0.name.lowercased().prefix(searchText.count) == searchText.lowercased() }
        ViewController().searching = true
                self.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        ViewController().searching = false
        searchBar.text = ""
        self.reloadData()

    }
}
