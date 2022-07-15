//
//  ExerciseDataSource.swift
//  Workout_SB
//
//  Created by Mark ⠀ on 6/23/21.
//

import UIKit

class ExerciseDataSource : NSObject, UITableViewDataSource, UITableViewDragDelegate, UITableViewDropDelegate  {
//    class ExerciseDataSource : NSObject, UITableViewDataSource  {
    
    
    ///Protocol stubs
    var collection = [Exercise]()
    
    init(collection: [Exercise]) {
        self.collection = collection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collection.count
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
    
    
    ///--
    
    ///Add swipe-left to delete
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        var actions = [UIContextualAction]()
//
//        let delete = UIContextualAction(style: .destructive, title: nil) { (_, _, completion) in
//
//            self.collection.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            let s = tableView.superview?.superview as! SetTableViewCell //wow.
//            s.reloadView()
//
//            completion(true)
//        }
//
//        let largeConfig = UIImage.SymbolConfiguration(pointSize: 17.0, weight: .bold, scale: .large)
//        delete.image = UIImage(systemName: "trash", withConfiguration: largeConfig)?.withTintColor(.white, renderingMode: .alwaysTemplate).addBackgroundCircle(.systemRed)
//        delete.backgroundColor = .systemBackground
//        delete.title = "Delete"
//
//        actions.append(delete)
//
//        let config = UISwipeActionsConfiguration(actions: actions)
//        config.performsFirstActionWithFullSwipe = true
//
//        return config
//    }
//
    /// --
    
    ///Drag and drop

    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {

    }

    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return []
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
    
     func tableView(_ tableView: UITableView,
                    canHandle session: UIDropSession) -> Bool {
        false
     }


    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.collection[sourceIndexPath.row]
        collection.remove(at: sourceIndexPath.row)
        collection.insert(movedObject, at: destinationIndexPath.row)
        
        ///#FIXME
        
        let s = tableView.superview?.superview as! SetTableViewCell
        let ss = s.superview as! UITableView
        let index2 = ss.indexPath(for: s)
        let d = ss.dataSource as! SetWithExercisesDataSource
        d.collection[index2!.item].exercises = collection
        
        
        
    }

    func tableView(_ tableView: UITableView, dragPreviewParametersForRowAt indexPath: IndexPath) -> UIDragPreviewParameters? {

        let param = UIDragPreviewParameters()
        let cell = tableView.cellForRow(at: indexPath)
        param.backgroundColor = .clear
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: cell!.frame.width, height: cell!.frame.height), cornerRadius: 9)
        param.visiblePath = path
        return param
    }

    func tableView(_ tableView: UITableView, dropPreviewParametersForRowAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        let param = UIDragPreviewParameters()
        let cell = tableView.cellForRow(at: indexPath)
        param.backgroundColor = .clear
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: cell!.frame.width, height: cell!.frame.height), cornerRadius: 9)
        param.visiblePath = path
        return param
    }


    /// --

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseTableViewCell", for: indexPath) as! ExerciseTableViewCell
//        cell.exerciseTitle.text = String("Exercise \(collection.count)") ///#FOR DEBUGGING
        cell.exerciseTitle.text = collection[indexPath.row].name
        cell.exerciseTimeEntry.text = collection[indexPath.row].time
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "HH:mm"
        let date = dateFormatter.date(from: collection[indexPath.row].time)
        cell.exerciseTimeEntry2.date = date!
        
//        cell.exerciseTimeEntry2.setDate(<#T##date: Date##Date#>, animated: <#T##Bool#>)
        
//        return cell
        cell.layoutIfNeeded()
        return cell
    }
    
    
    
}


extension UIImage {

    func addBackgroundCircle(_ color: UIColor?) -> UIImage? {

        let circleDiameter = max(size.width * 2, size.height * 2)
        let circleRadius = circleDiameter * 0.5
        let circleSize = CGSize(width: circleDiameter, height: circleDiameter)
        let circleFrame = CGRect(x: 0, y: 0, width: circleSize.width, height: circleSize.height)
        let imageFrame = CGRect(x: circleRadius - (size.width * 0.5), y: circleRadius - (size.height * 0.5), width: size.width, height: size.height)

        let view = UIView(frame: circleFrame)
        view.backgroundColor = color ?? .systemRed
        view.layer.cornerRadius = circleDiameter * 0.5

        UIGraphicsBeginImageContextWithOptions(circleSize, false, UIScreen.main.scale)

        let renderer = UIGraphicsImageRenderer(size: circleSize)
        let circleImage = renderer.image { ctx in
            view.drawHierarchy(in: circleFrame, afterScreenUpdates: true)
        }

        circleImage.draw(in: circleFrame, blendMode: .normal, alpha: 1.0)
        draw(in: imageFrame, blendMode: .normal, alpha: 1.0)

        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return image
    }
}

