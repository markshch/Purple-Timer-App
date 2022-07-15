//
//  ExerciseTableView.swift
//  Workout_SB
//
//  Created by Mark ⠀ on 6/23/21.
//

import UIKit

class ExerciseTableView: UITableView {

    override var intrinsicContentSize: CGSize {
            self.layoutIfNeeded()
            return self.contentSize
        }

        override var contentSize: CGSize {
            didSet{
                self.invalidateIntrinsicContentSize()
            }
        }

        override func reloadData() {
            super.reloadData()
            self.invalidateIntrinsicContentSize()
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
    
    
}
