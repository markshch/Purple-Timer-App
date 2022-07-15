//
//  WorkoutViewController.swift
//  Workout_SB
//
//  Created by Mark ⠀ on 8/3/21.
//

///TO FIX
/*
 -  Change DisplayDataSrouce to take in [Exercise]
 -  Create logic for iterating thru Display based on totalTimeInSeconds == (initialTotalTimeInSeconds - [Exercise][0].time)
 -  Good luck lol
 */

import UIKit
import AVFoundation


class WorkoutViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet var exitButton: UIButton!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var totalProgress: UIProgressView!
    @IBOutlet var exerciseDisplay: UITableView!
    @IBOutlet var progressBar: ProgressBarView!
    var player: AVAudioPlayer?
    
    var dataSource: DisplayDataSource!
    var keepTimerRunning = true
    var l = UILabel()
    let b = UIButton(frame: CGRect(x: 0, y: 0, width: 185, height: 70))
    var sample = [Exercise]()
    var timeInSeconds = 0
    
    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//
//    }
    func playSound() {
        guard let path = Bundle.main.path(forResource: "beep2", ofType:"wav") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
                
        
        //Exit button
        exitButton.layer.cornerRadius = 25
        exitButton.imageView?.tintColor = .label
        
        l = UILabel(frame: CGRect(x: self.view.frame.minX, y: self.view.frame.minY, width: 600, height: 100))
        
//        var sample = ["Abs", "Reverse Leg Crunch", "ReSt", "Plank", "Abs", "Spaghetti", "Push-ups", "Rest", "Squats"]
        
        //Display table
        let dataSource = DisplayDataSource(using: sample)
        
        self.dataSource = dataSource
        exerciseDisplay.delegate = self
        exerciseDisplay.dataSource = self.dataSource
        exerciseDisplay.alpha = 0
        
        
    
        
        ///VOICE
        var utterance = AVSpeechUtterance(string: "Jump squats")
//        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
//        utterance.voice = AVSpeechSynthesisVoice(identifier: "Daniel")
        //        utterance.voice.
//        utterance.rate = 0.05
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setCategory(
            AVAudioSession.Category.playback,
            options: AVAudioSession.CategoryOptions.mixWithOthers
        )

        

        let synthesizer = AVSpeechSynthesizer()
        
//        synthesizer.speak(utterance)

  
        //Timer code
        
        var seconds = timeInSeconds   // 2 minutes 5 seconds
        progressBar.progress = 0.0
        let progressStep = CGFloat(100.0/(Double(seconds)*100.0))
        totalProgress.progress = 0.000
        
        
        
        var secondsToMinutes = self.convertToTimeString((seconds % 3600) / 60)
        var secondsToString = self.convertToTimeString(seconds % 60)
        
        
        self.timeLabel.text = "\(secondsToMinutes):\(secondsToString)"
        
        timeLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 100, weight: UIFont.Weight.bold)

        var initialSeconds = seconds
        var firstRunSeconds = seconds
        
        let firstExercise = sample[0].name
//        utterance = AVSpeechUtterance(string: firstExercise)
//        synthesizer.speak(utterance)
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            
            if (!self.keepTimerRunning) {timer.invalidate()}
        
            if (seconds == firstRunSeconds ) {
                let utterance = AVSpeechUtterance(string: firstExercise)
                synthesizer.speak(utterance)
            }
            
            seconds -= 1
            secondsToMinutes = self.convertToTimeString((seconds % 3600) / 60)
            secondsToString = self.convertToTimeString(seconds % 60)
            if seconds == 0 {
                
                self.timeLabel.text = "\(secondsToMinutes):\(secondsToString)"
                self.progressBar.progress += progressStep
                
             
                
                
                timer.invalidate()
                
                self.performSegue(withIdentifier: "completion2", sender: nil)
                
                
            } else {
                if (seconds == 3) {
                    self.playSound()

//                    let v = UIView(frame: self.view.frame)
//                    ///Sun-set the view
//                    v.backgroundColor = .black
//                    v.layer.opacity = 0.0
//
//
//                    self.view.addSubview(v)
//
//                    UIView.animate(withDuration: 4.0) {
//                        v.layer.opacity = 1.0
//
//                    }
                }
                if (seconds == initialSeconds - dataSource.collection[0].time.toTime()) {
                    initialSeconds = seconds
                    dataSource.collection.remove(at: 0)
                    let indexPath = IndexPath(item: 0, section: 0)
                    UIView.animate(withDuration: 0.45) {
                        self.exerciseDisplay.cellForRow(at: IndexPath(item: 0, section: 0))?.contentView.alpha = 0.0
                        self.exerciseDisplay.deleteRows(at: [indexPath], with: .none)
                    }
//                    self.exerciseDisplay.deleteRows(at: [indexPath], with: .none)
                    UIView.animate(withDuration: 1) {
                        self.exerciseDisplay.cellForRow(at: IndexPath(item: 2, section: 0))?.contentView.alpha = 1.0
                    }
                    
                    let topMostCell = self.exerciseDisplay.cellForRow(at: IndexPath(item: 0, section: 0)) as! DisplayTableViewCell
                    let utterance = AVSpeechUtterance(string: topMostCell.exerciseTitle.text!.lowercased())
//                    utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.Karen-compact")
                    
                    
                    synthesizer.speak(utterance)
                    


                }
                self.timeLabel.text = "\(secondsToMinutes):\(secondsToString)"
                self.progressBar.progress += progressStep

            }
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let topMostCell = exerciseDisplay.cellForRow(at: IndexPath(item: 0, section: 0)) as! DisplayTableViewCell
//        let utterance = AVSpeechUtterance(string: topMostCell.exerciseTitle.text!.lowercased())
////        let utterance = AVSpeechUtterance(string: "Abs")
//        utterance.voice = AVSpeechSynthesisVoice(identifier: "Daniel")
//        let synthesizer = AVSpeechSynthesizer()
//        synthesizer.speak(utterance)
        
        UIView.animate(withDuration: 1.5) {
            self.exerciseDisplay.alpha = 1.0
        }
        

        
    }
    
    @IBAction func exitPressed(_ sender: Any) {
        keepTimerRunning = false
//        performSegue(withIdentifier: "exit", sender: self)
        
    }
    
    @objc func reloadView() {
//        performSegue(withIdentifier: "startWorkout", sender: self)
    }
    
    func convertToTimeString(_ int : Int) -> String {
        if (int < 10) {
            return "0\(int)"
        }
        return "\(int)"
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        exerciseDisplay.setNeedsUpdateConstraints()
        if UIDevice.current.orientation.isLandscape {
            
            
        } else {
            
            
        }
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier != "completion2") {
            return
            
        }
        let vc = segue.destination
        self.view.applyBlurEffect()
        vc.view.backgroundColor = .clear
        
        vc.modalPresentationStyle = .overCurrentContext
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}

extension UIProgressView {
    @available(iOS 10.0, *)
    func setAnimatedProgress(progress: Float = 1, duration: Float = 1, completion: (() -> ())? = nil) {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            DispatchQueue.main.async {
                let current = self.progress
                self.setProgress(current+(1/duration), animated: true)
            }
            if self.progress >= progress {
                timer.invalidate()
                if completion != nil {
                    completion!()
                }
            }
        }
    }
}

extension String {
    func toTime() -> Int {
        var totalTime = 0
        let components = self.split { $0 == ":" } .map { (x) -> Int in return Int(String(x))! }

        totalTime += (components[0] * 60)
        totalTime += components[1]
        
        return totalTime
    }
}





