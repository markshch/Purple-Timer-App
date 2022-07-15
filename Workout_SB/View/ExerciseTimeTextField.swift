//
//  exerciseTimeTextField.swift
//  Workout_SB
//
//  Created by Mark ⠀ on 8/17/21.
//

import UIKit

class ExerciseTimeTextField: UITextField, UITextFieldDelegate {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        self.delegate = self
    }
    
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return !isFirstResponder
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 5
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        
        let allowedCharacters = "1234567890"
        let allowedCharcterSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharcterSet = CharacterSet(charactersIn: string)
        
        return newString.length <= maxLength && allowedCharcterSet.isSuperset(of: typedCharcterSet)

    }

}
