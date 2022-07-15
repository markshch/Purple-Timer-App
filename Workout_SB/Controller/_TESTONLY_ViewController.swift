//
//  _TESTONLY_ViewController.swift
//  Workout_SB
//
//  Created by Mark ⠀ on 8/4/21.
//

import UIKit

class _TESTONLY_ViewController: UIViewController {

    
    @IBOutlet var TF: UITextField!
    @IBOutlet var navBarTitle: UINavigationItem!
    
    @IBAction func TAP(_ sender: Any) {
        
        TF.becomeFirstResponder()
        
        
    }
    @IBAction func TEXT_END(_ sender: UITextField) {
        navBarTitle.title = sender.text ?? ""
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let timePicker: UIPickerView = UIPickerView()
        //assign delegate and datasoursce to its view controller
        timePicker.delegate = self
        timePicker.dataSource = self

        // setting properties of the pickerView
        timePicker.frame = CGRect(x: 0, y: 50, width: self.view.frame.width, height: 200)
        timePicker.backgroundColor = .white

        // add pickerView to the view
//        self.view.addSubview(timePicker)
        

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension _TESTONLY_ViewController: UIPickerViewDelegate, UIPickerViewDataSource{

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 60
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(format: "%02d", row)
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            let minute = row
            
        }else{
            let second = row
            
        }
    }
}
