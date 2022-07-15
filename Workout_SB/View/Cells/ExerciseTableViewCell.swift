//
//  ExerciseTableViewCell.swift
//  Workout_SB
//
//  Created by Mark ⠀ on 6/23/21.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {

    @IBOutlet var exerciseTitle: UITextField!
    @IBOutlet var exerciseTime: UITextField!
    @IBOutlet var exerciseCellView: UIView!
    @IBOutlet var exercuseTimeView: UIView!
    @IBOutlet var exerciseTimeEntry: UITextField!
    
    @IBOutlet var exerciseTimeEntry2: UIDatePicker!
    
    var warningView = UIButton()
    




    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .clear
//        exerciseTimeEntry.layer
        exerciseCellView.layer.cornerRadius = 9
        exerciseCellView.backgroundColor = .systemGray5
//        self.layer.cornerRadius = 9
        // Initialization code
//        exerciseTimeEntry.layer.cornerRadius = 11
//        exerciseTimeEntry.backgroundColor = .link
        

        
        
        
        
        exerciseTimeEntry2.layer.backgroundColor =  UIColor(red: 0.1686, green: 0.5294, blue: 0.8863, alpha: 1.0).cgColor
        exerciseTimeEntry2.backgroundColor = UIColor(red: 0.1686, green: 0.5294, blue: 0.8863, alpha: 1.0)
//        exerciseTimeEntry2.inputView?.backgroundColor = UIColor(red: 0.3647, green: 0.349, blue: 0.7176, alpha: 1.0)
//        exerciseTimeEntry2.inputView?.layer.backgroundColor = UIColor(red: 0.3647, green: 0.349, blue: 0.7176, alpha: 1.0).cgColor
//        exerciseTimeEntry2.layer.setNeedsLayout()
//        exerciseTimeEntry2.layer.setNeedsDisplay()
//        exerciseTimeEntry2.layer.borderWidth = 0.1
//        exerciseTimeEntry2.setNeedsLayout()
//        exerciseTimeEntry2.setNeedsDisplay()
        exerciseTimeEntry2.layer.cornerRadius = 14.333333
        
        
//        exerciseTimeEntry2.layer.frame = CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
//        exerciseTimeEntry2.layer.masksToBounds = true
        exerciseTimeEntry2.tintColor = .white
        
//        exerciseTimeEntry2.setValue(".white", forKeyPath: "textColor")
//        exerciseTimeEntry2.inputView?.tintColor = .white
//        exerciseTimeEntry2.inputAccessoryView?.tintColor = .white
//        exerciseTimeEntry2.clipsToBounds = true
//                exerciseTimeEntry2.layer.setNeedsLayout()
//                exerciseTimeEntry2.layer.setNeedsDisplay()
        let time = String(DateFormatter.localizedString(from: exerciseTimeEntry2.date, dateStyle: .medium, timeStyle: .short))
        
        let df = DateFormatter()
        df.locale = Locale(identifier: "fr_FR")
        df.timeStyle = .short
        let ss1 = df.string(from: exerciseTimeEntry2.date)
        print("STRING: \(ss1)")
        exerciseTimeEntry.selectedTextRange = exerciseTimeEntry.textRange(from: exerciseTimeEntry.endOfDocument, to: exerciseTimeEntry.endOfDocument)
        
//        self.contentView.frame
        
//        let rectFrame: CGRect = CGRect(x:CGFloat(self.frame.midX * 1.25), y:CGFloat(25 / 2), width:CGFloat(20), height:CGFloat(20))
//                let rectFrame: CGRect = CGRect(x:CGFloat(exerciseTimeEntry.frame.midX - 20), y:CGFloat(exerciseTimeEntry.frame.midY), width:CGFloat(20), height:CGFloat(20))
//        warningView = UIButton(frame: rectFrame)
//        warningView.layer.cornerRadius = 9
//        warningView.backgroundColor = .systemYellow
//        warningView.setTitle("→", for: .normal)
//        warningView.titleLabel?.font = UIFont.systemFont(ofSize: 13)
//        warningView.setTitleColor(.black, for: .normal)
//        self.addSubview(warningView)
//        warningView.alpha = 0
        
//        if exerciseTimeEntry.text == "00:00" {
//            warningView.alpha = 1
//        }
//        else {
//            warningView.alpha = 0
//        }
        

        
    }
    
    @IBAction func moveCursorToEnd(_ sender: UITextField) {
        DispatchQueue.main.async {
            sender.selectedTextRange = sender.textRange(from: sender.endOfDocument, to: sender.endOfDocument)
        }

    }
    
    
    @IBAction func checkFormatting(_ sender: ExerciseTimeTextField) {
        if (sender.text?.count == 3) {
            let str = sender.text!
            let index = str.index(str.startIndex, offsetBy: 2)
            
            if (str[index] != ":") {
                var chars = Array(sender.text!)
                chars.insert(":", at: 2)
                sender.text? = String(chars)
            }
            else {
                var chars = Array(sender.text!)
                _ = chars.popLast()
                sender.text? = String(chars)
            }
        }
        else if (sender.text!.count < 5) {
            UIView.animate(withDuration: 0.50) {
                self.warningView.alpha = 1.0
            }
        }
        
        if (sender.text!.count == 5) {
            UIView.animate(withDuration: 0.50) {
                self.warningView.alpha = 0
            }
        }
        
        warningView.alpha = 0
        
        if (sender.text! == "00:00") {
            UIView.animate(withDuration: 0.50) {
                self.warningView.alpha = 1.0
            }
        }
        
        else {
            UIView.animate(withDuration: 0.50) {
                self.warningView.alpha = 0
            }
        }
        
        
    }
    
    

    
    func getIndexPath() -> IndexPath? {
        guard let superView = self.superview as? UITableView else {
            print("superview is not a UITableView - getIndexPath")
            return nil
        }
        var indexPath = superView.indexPath(for: self)
        return indexPath
    }
    
 
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
