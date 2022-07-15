//
//  CompletionViewController.swift
//  Workout_SB
//
//  Created by Mark ⠀ on 10/12/21.
//

import UIKit

class CompletionViewController: UIViewController {
    
    @IBOutlet var homeButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        homeButton.imageView?.tintColor = .white
        homeButton.layer.cornerRadius = 22
        
        
//        self.view.backgroundColor = .clear
//        self.modalPresentationStyle = .overCurrentContext
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func exitPressed(_ sender: Any) {
        self.modalPresentationStyle = .automatic
        
//        navigationController?.popToRootViewController(animated:false)
        UIView.animate(withDuration: 0.25) {
            self.view.layer.opacity = 0
        }
//        performSegue(withIdentifier: "b", sender: nil)
        
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
//        let vc = segue.destination as! ViewController
//        vc.workoutsTableView.reloadData()
        
    }
    

}

extension UIView {
    func applyBlurEffect() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
}
