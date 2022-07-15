//
//  SettingsViewController.swift
//  Workout_SB
//
//  Created by Mark ⠀ on 8/29/21.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet var segControl: UISegmentedControl!
    @IBOutlet var viewa: UIView! ///replace this with VIEW class
    @IBOutlet var viewb: UIView!
    @IBOutlet var viewc: UIView!
    @IBOutlet var viewd: UIView!
    @IBOutlet var viewe: UIView!
    @IBOutlet var viewf: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segControl.selectedSegmentIndex = 2
        // Do any additional setup after loading the view.
        let corn: CGFloat = 13
        viewa.layer.cornerRadius = corn
        viewb.layer.cornerRadius = corn
        viewc.layer.cornerRadius = corn
        viewd.layer.cornerRadius = corn
        viewe.layer.cornerRadius = corn
        viewf.layer.cornerRadius = corn
        
        
        
    }
    
    func disable(views: [UIView]) {
        for view in views {
            view.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.35) {
                view.alpha = 0.3
            }
            
        }
    }
    
    func enable(views: [UIView]) {
        for view in views {
            view.isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.35) {
                view.alpha = 1.0
            }
            
        }
    }
    
    
    @IBAction func changeModePerference(_ sender: UISegmentedControl) {
        
        switch(sender.selectedSegmentIndex) { ///https://stackoverflow.com/questions/66391172/how-to-change-app-theme-light-dark-programmatically-in-swift-5
        case 0:
            
            UIApplication.shared.keyWindow!.overrideUserInterfaceStyle = .light
            
        case 1:
            UIApplication.shared.keyWindow!.overrideUserInterfaceStyle = .dark
            
            
        default:
            UIApplication.shared.keyWindow!.overrideUserInterfaceStyle = .unspecified
        
        }
    }
    
    @IBAction func voiceOff(_ sender: UISwitch) {
        if(sender.isOn) {
            enable(views: [viewb,viewc,viewd,viewe,viewf])
        }
        else {
            disable(views: [viewb,viewc,viewd,viewe,viewf])
        }
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
