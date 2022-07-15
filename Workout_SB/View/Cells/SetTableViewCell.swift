//
//  SetTableViewCell.swift
//  Workout_SB
//
//  Created by Mark ⠀ on 6/18/21.
//


///## Needs logic to save MySet model
/// 

import UIKit

class SetTableViewCell: UITableViewCell, UITableViewDelegate {
    
    @IBOutlet var setTitle: UILabel!
    @IBOutlet var exerciseCount: UILabel!
    @IBOutlet var setMenuButton: UIButton!
    @IBOutlet var exerciseTable: ExerciseTableView!
    var sample = [Exercise]()
    var dataSource: ExerciseDataSource!
    
    
    
    override func awakeFromNib() {

        super.awakeFromNib()
        self.layer.cornerRadius = 20
        self.contentView.layer.borderWidth = 5
        self.contentView.layer.borderColor = UIColor.systemBackground.cgColor
        self.contentView.layer.cornerRadius = 20
        
        if (sample.count == 0) {
//        sample.append(Exercise(name: "Generic Exercise", time: "00:00")) ///FIXME: "0" "0"
        }
        
        exerciseTable.backgroundColor = .clear
        
        exerciseTable.delegate = self
        print(sample.count)
        let dataSource = ExerciseDataSource(collection: sample)
        
        self.dataSource = dataSource
        exerciseTable.dataSource = self.dataSource
        exerciseTable.estimatedRowHeight = 50.0
//        exerciseTable.rowHeight = UITableView.automaticDimension
        exerciseTable.dragInteractionEnabled = true
        exerciseTable.dragDelegate = dataSource
//        self.backgroundColor = .red
        exerciseTable.dropDelegate = dataSource
        
        
//        ///pop over menu setup
//
//        let usersItem = UIAction(title: "Move To The Top", image: UIImage(systemName: "arrow.up")) { (action) in
//
//              print("Users action was tapped")
//         }
//
//         let addUserItem = UIAction(title: "Duplicate Set", image: UIImage(systemName: "wallet.pass")) { (action) in
//
//             print("Add User action was tapped")
//         }
//
//         let removeUserItem = UIAction(title: "Delete Set", image: UIImage(systemName: "delete.right")) { (action) in
//              print("Remove User action was tapped")
//         }
//
//        let deleteInfoItem = UIAction(title: "Delete Exercise?", image: UIImage(systemName: "info")) { (action) in
//            let alert = UIAlertController(title: "Did you bring your towel?", message: "It's recommended you bring your towel before continuing.", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
//
//            self.window?.rootViewController?.self.present(alert, animated: false, completion: nil) ///FIXME: DOESNT WORK
//
//        }
//
//        let menu = UIMenu(options: .displayInline, children: [usersItem , addUserItem , removeUserItem, deleteInfoItem])
//
//        setMenuButton.menu = menu
//        setMenuButton.showsMenuAsPrimaryAction = true
        
    }
    
    
    @IBAction func addExercise(_ sender: Any) {
        dataSource.collection.append(Exercise(name: "Generic Exercise", time: "00:01"))
//        exerciseTable.beginUpdates()
        exerciseTable.insertRows(at: [IndexPath.init(row: dataSource.collection.count - 1, section: 0)], with: .left)
//        exerciseTable.endUpdates()
        exerciseTable.layoutIfNeeded()
        
        exerciseCount.text = String(Int(exerciseCount.text!)! + 1) //wow.

//        let s = self.superview as! UITableView
//        let index2 = s.indexPath(for: self)
//        let d = s.dataSource as! SetWithExercisesDataSource
//        d.collection[index2!.item].exercises = dataSource.collection
        
        
//        self.layoutIfNeeded()
//        print(s.dataSource)
        reloadView()
//        print(s.dataSource)

    }
    
    @IBAction func checkForGeneric(_ sender: UITextField) {
        
        if (sender.text == "Generic Exercise") {
            UIView.transition(with: sender,
                          duration: 0.25,
                          options: .transitionFlipFromLeft,
                        animations: { [weak self] in
                            sender.text = ""
                     }, completion: nil)
        }
        }
    
    
    func reloadView() {
        let s = self.superview as! UITableView
        UIView.transition(with: s, duration: 0.15, options: [], animations: {s.reloadData()}, completion: nil) ///NEED BETTER IMPLEMENTATION
    }
    
///DELETE
    
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

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        var actions = [UIContextualAction]()

        let delete = UIContextualAction(style: .normal, title: nil) { [weak self] (contextualAction, view, completion) in

            self?.dataSource.collection.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            let s = tableView.superview?.superview as! SetTableViewCell //wow.
            
            
            ///FIXME: Move the below code somewhere.
            let ss = self?.superview as! UITableView
            let index2 = ss.indexPath(for: s)
            let d = ss.dataSource as! SetWithExercisesDataSource
            d.collection[index2!.item].exercises = self!.dataSource.collection
            
            s.reloadView()

            completion(true)
        }

        let largeConfig = UIImage.SymbolConfiguration(pointSize: 11.0, weight: .bold, scale: .large)
        delete.image = UIImage(systemName: "trash", withConfiguration: largeConfig)?.withTintColor(.white, renderingMode: .alwaysTemplate).addBackgroundCircle(.systemRed)
        delete.backgroundColor = .systemGray6
        delete.title = "Delete"

        actions.append(delete)

        let config = UISwipeActionsConfiguration(actions: actions)
        config.performsFirstActionWithFullSwipe = true
        
        

        return config
    }
    
    ///--
    
    ///Drag and drop
    
//    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
//
//    }

//    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
//        if indexPath.section != 2 {
//            print("DDLL")
//            return []
//        }
//        return []
//        return [UIDragItem(itemProvider: NSItemProvider())]
//    }

//
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        print("MOVING")
//        let movedObject = self.dataSource.collection[sourceIndexPath.row - 1]
//        dataSource.collection.remove(at: sourceIndexPath.row)
//        dataSource.collection.insert(movedObject, at: destinationIndexPath.row)
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
    
    /// --
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.contentView.layer.borderColor = UIColor.systemBackground.cgColor
        self.setNeedsDisplay()
    }



    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func saveExerciseTitle(_ sender: UITextField) {
        let ecell = sender.superview?.superview?.superview as! ExerciseTableViewCell
        let index = exerciseTable.indexPath(for: ecell)
        self.dataSource.collection[index!.item].name = sender.text ?? "OGGA"
//        dataSource = ExerciseDataSource(collection: dataSource.collection)
        let s = self.superview as! UITableView
        let index2 = s.indexPath(for: self)
        let d = s.dataSource as! SetWithExercisesDataSource
        d.collection[index2!.item].exercises = dataSource.collection
    }
    
    
    
    @IBAction func saveExerciseTime(_ sender: ExerciseTimeTextField) {
        
//        let indx = exerciseTable.indexPath(for: sender.superview?.superview?.superview as! ExerciseTableViewCell)
//        var savetext = sender.text
//        if (savetext == "00:00") {savetext = "00:01"}
//        self.dataSource.collection[indx!.item].time = sender.text ?? "0s"
//        
//        
//        let s = self.superview as! UITableView
//        let index2 = s.indexPath(for: self)
//        let d = s.dataSource as! SetWithExercisesDataSource
//        d.collection[index2!.item].exercises = dataSource.collection
    }
    
    @IBAction func saveDateTime(_ sender: UIDatePicker) {
        
        let df = DateFormatter()
        df.locale = Locale(identifier: "fr_FR")
        df.timeStyle = .short
        var ss1 = df.string(from: sender.date)
        
        if (ss1 == "00:00") {
            ss1 = "00:01"
        }
        
        let indx = exerciseTable.indexPath(for: sender.superview?.superview?.superview as! ExerciseTableViewCell)
        self.dataSource.collection[indx!.item].time = ss1
        
        let s = self.superview as! UITableView
        let index2 = s.indexPath(for: self)
        let d = s.dataSource as! SetWithExercisesDataSource
        d.collection[index2!.item].exercises = dataSource.collection
        
    }
    
    
    
}
