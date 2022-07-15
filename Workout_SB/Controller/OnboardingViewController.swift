//
//  OnboardingViewController.swift
//  Workout_SB
//
//  Created by Mark ⠀ on 6/26/21.
//

import UIKit

class OnboardingViewController: UIViewController {
    @IBOutlet var stackViewTopConstraint: NSLayoutConstraint!
    @IBOutlet var nextButton: UIButton!
    
    @IBAction func leaveOnboarding(_ sender: Any) {
        performSegue(withIdentifier: "leaveOnboarding1", sender: self)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        nextButton.layer.cornerRadius = 7
        
        defaults.set(1, forKey: "Onboarding")

        
        

        // Do any additional setup after loading the view.
    }
    func viewWillAppear() {
        performSegue(withIdentifier: "leaveOnboarding", sender: self)

    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}

