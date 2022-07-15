
import UIKit

class SetWithExercisesDataSource : NSObject, UITableViewDataSource, UITableViewDragDelegate {

    
//    class SetWithExercisesDataSource : NSObject, UITableViewDataSource {
    var collection = [SetWithExercises]()
    var workoutName = ""
    var count = 0
    
//    init(collection: [SetWithExercises]) {
//        self.collection = collection
//    }
    
        init(sets: [SetWithExercises]) {
            self.collection = sets
            self.count = sets.count
        }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return count
        }
        else {
            return 1
        }
    }
    
//    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        true
//    }
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        // Update the model
//        self.collection.swapAt(sourceIndexPath.row, destinationIndexPath.row)
//        
////        self.reloadData()
//    }
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return UITableViewCell.EditingStyle.none
//    }
//    
//    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
//        return false
//    }
    
    ///Add swipe-left to delete

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        var actions = [UIContextualAction]()

        let delete = UIContextualAction(style: .destructive, title: nil) { (_, _, completion) in

            self.collection.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            let s = tableView.superview?.superview as! SetTableViewCell //wow.
            s.reloadView()

            completion(true)
        }

        let largeConfig = UIImage.SymbolConfiguration(pointSize: 17.0, weight: .bold, scale: .large)
        delete.image = UIImage(systemName: "trash", withConfiguration: largeConfig)?.withTintColor(.white, renderingMode: .alwaysTemplate).addBackgroundCircle(.systemRed)
        delete.backgroundColor = .systemBackground
        delete.title = "Delete"

        actions.append(delete)

        let config = UISwipeActionsConfiguration(actions: actions)
        config.performsFirstActionWithFullSwipe = true

        return config
    }

    /// --
    
//    /Drag and drop
    
//    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
//
//    }

    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        if indexPath.section != 2 {
            return []
        }
        return []
    }
    
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath
    {
      if sourceIndexPath.section == proposedDestinationIndexPath.section
      {
        return proposedDestinationIndexPath
      } else {
        return sourceIndexPath
      }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section != 1 {
            
            return false
        }
        return true
    }


    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.collection[sourceIndexPath.row]
        collection.remove(at: sourceIndexPath.row)
        collection.insert(movedObject, at: destinationIndexPath.row)
    }
    
//    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
//        if sourceIndexPath.section != proposedDestinationIndexPath.section {
//            var row = 0
//            if sourceIndexPath.section < proposedDestinationIndexPath.section {
//                row = self.tableView(tableView, numberOfRowsInSection: sourceIndexPath.section) - 1
//            }
//            return IndexPath(row: row, section: sourceIndexPath.section)
//        }
//        return proposedDestinationIndexPath
//    }

//    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
//        print("ACTALL")
//        if sourceIndexPath.section != proposedDestinationIndexPath.section {
//            var row = 0
//            if sourceIndexPath.section < proposedDestinationIndexPath.section {
//                row = tableView.numberOfRows(inSection: sourceIndexPath.section) - 1
//            }
//            return IndexPath(row: row, section: sourceIndexPath.section)
//        }
//        return proposedDestinationIndexPath
//    }
    


    func tableView(_ tableView: UITableView, dragPreviewParametersForRowAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        let cell = tableView.cellForRow(at: indexPath)
        let param = UIDragPreviewParameters()
        param.backgroundColor = .clear

        let path = UIBezierPath(roundedRect: CGRect(x: 4.5, y: 4.5, width: cell!.frame.width - 9, height: cell!.frame.height - 9), cornerRadius: 20)
        param.visiblePath = path
        return param
    }

    func tableView(_ tableView: UITableView, dropPreviewParametersForRowAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        let param = UIDragPreviewParameters()
        param.backgroundColor = .clear
        let cell = tableView.cellForRow(at: indexPath)
        let path = UIBezierPath(roundedRect: CGRect(x: 4.5, y: 4.5, width: cell!.frame.width - 9, height: cell!.frame.height - 9), cornerRadius: 20)
        param.visiblePath = path
        return param
    }
    
    
    
    

    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            return tableView.dequeueReusableCell(withIdentifier: "WorkoutNameTableViewCell", for: indexPath) as! WorkoutNameTableViewCell //cell #1
        case 1:
            var cell = tableView.dequeueReusableCell(withIdentifier: "SetTableViewCell", for: indexPath) as! SetTableViewCell //cell #2

            ///TODO: Modify cell.[[setTitle]] to reflect the set count ... Set 1 >> Set 2 >> Set 3 ...
            if (cell.sample.count == 0) {
                cell.sample = collection[indexPath.row].exercises
                cell.awakeFromNib()
            }
            
//            cell.dataSource = ExerciseDataSource(collection: collection[indexPath.row].exercises)

            return cell
            
        case 3:
            return tableView.dequeueReusableCell(withIdentifier: "spaceTableViewCell", for: indexPath)

        default:
            return tableView.dequeueReusableCell(withIdentifier: "NewSetTableViewCell", for: indexPath) as! NewSetTableViewCell
        }
        
    }
    
    
    
}
