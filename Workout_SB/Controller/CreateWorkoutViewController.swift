//
//  CreateWorkoutViewController.swift
//  Workout_SB
//
//  Created by Mark ⠀ on 6/15/21.
//

///### Set modify page view controller

///TODO
//TODO: Add character limit to Name textfield

import UIKit
import CoreData



class CreateWorkoutViewController: UIViewController, UITableViewDelegate {
    
    
    var returnData = MyWorkout()
    
    var areWeEditing = false
    var editingIndex = -1
    
    

    @IBOutlet var navBarTitle: UINavigationItem!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    
    var dataSource: SetWithExercisesDataSource!
    var sample = [SetWithExercises]()
    var count = 1
    var changeMeView = UIButton()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func addNewSet(_ sender: Any) {
        dataSource.count = dataSource.count + 1
        dataSource.collection.append(SetWithExercises(exercises: [Exercise(name: "Generic Exercise", time: "00:01")]))
        setupTable.beginUpdates()
        setupTable.insertRows(at: [IndexPath.init(row: dataSource.count - 1, section: 1)], with: .automatic)
//        setupTable.reloadData()
        setupTable.endUpdates()
        
        
        
    }
    
    
    @IBOutlet var setupTable: UITableView!

    ///Add swipe-left to delete

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        var actions = [UIContextualAction]()
        
        if indexPath.section != 1 {return nil}

        let delete = UIContextualAction(style: .destructive, title: nil) { (_, _, completion) in
            
            ///##FIXME: Doesn't delete properly.

            self.dataSource.collection.remove(at: indexPath.row)
            self.dataSource.count -= 1
            tableView.deleteRows(at: [indexPath], with: .fade)
//            let s = tableView.superview?.superview as! SetTableViewCell //wow.
//            s.reloadView()

            completion(true)
        }

        let largeConfig = UIImage.SymbolConfiguration(pointSize: 17.0, weight: .bold, scale: .large)
        delete.image = UIImage(systemName: "trash", withConfiguration: largeConfig)?.withTintColor(.white, renderingMode: .alwaysTemplate).addBackgroundCircle(.systemRed)
        delete.backgroundColor = .systemBackground
//        delete.title = ""

        actions.append(delete)

        let config = UISwipeActionsConfiguration(actions: actions)
        config.performsFirstActionWithFullSwipe = true

        return config
    }

    /// --
    @objc func dissMissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dissMissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
//        self.navigationBar.topItem.title = "some title"
        
//        print("wrkname :\(dataSource.workoutName)")
        

        // Do any additional setup after loading the view.
        let button = UIButton(frame: CGRect(origin: CGPoint(x: (self.view.frame.width - 180)/2, y: self.view.frame.size.height - 30), size: CGSize(width: self.view.frame.width - 220, height: 70)))
        
        button.backgroundColor = .systemBlue
//        button.center = self.view.center
        button.frame = CGRect(x: self.view.frame.size.width/2 - button.frame.size.width/2, y: self.view.frame.size.height - 100, width: self.view.frame.width - 220, height: 70)
        button.setTitle("  Start", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 18.0)
        button.layer.cornerRadius = 35
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.imageView?.tintColor = .white
        self.view.addSubview(button)
        
        
        if (/* core data failed == */ sample.count == 0) { ///running an empty workout
            sample.append(SetWithExercises(exercises: [Exercise(name: "Generic Exercise", time: "00:01")]))
        }
        
        
        setupTable.delegate = self
        
        
        
        let dataSource = SetWithExercisesDataSource(sets: sample)
        if (self.dataSource == nil) {
            
            self.dataSource = dataSource
        }
//        print(sample)
        setupTable.dataSource = self.dataSource
        setupTable.alwaysBounceVertical = false
        setupTable.dragInteractionEnabled = true
        setupTable.dragDelegate = self.dataSource
///        setupTable.dropDelegate = dataSource

        let rectFrame: CGRect = CGRect(x:CGFloat(225), y:CGFloat(45), width:CGFloat(85), height:CGFloat(20))
        changeMeView = UIButton(frame: rectFrame)
        changeMeView.layer.cornerRadius = 9
        changeMeView.backgroundColor = .systemYellow
        changeMeView.setTitle("  ← Change Me  ", for: .normal)
//        let img = UIImage(named: <#T##String#>)
//        greenView.setIm
        changeMeView.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        changeMeView.setTitleColor(.black, for: .normal)
        setupTable.addSubview(changeMeView)
        changeMeView.alpha = 0

        
        
//        button.applyGradient(colors: [UIColor.blue.cgColor, UIColor.systemTeal.cgColor])
        button.applyGradient()
        _ = button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        let centerXConstraint = NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        NSLayoutConstraint.activate([centerXConstraint])
        
        button.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        

    }
    
    @objc func startButtonPressed() {
        
        performSegue(withIdentifier: "startWorkout", sender: self)
    }
    
    
    override func viewDidLayoutSubviews() {
//        setupTable.reloadData()
        let nameCell = setupTable.cellForRow(at: IndexPath(row: 0, section: 0)) as! WorkoutNameTableViewCell
        nameCell.workoutName.text = dataSource.workoutName
        
        navBarTitle.title = dataSource.workoutName ?? "New Workout"
        
        ///#PENDING DELETE
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        let nameCell = setupTable.cellForRow(at: IndexPath(row: 0, section: 0)) as! WorkoutNameTableViewCell
//        nameCell.workoutName.text = dataSource.workoutName
        if (dataSource.workoutName == "") {
            UIView.animate(withDuration: 0.75) {
                self.changeMeView.alpha = 1.0
            }
        }
        
        
        
        
    }
    
    
    
    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "unwindHome") { ///<<<<<
            
            let segueHome = segue.destination as! ViewController
//            updateData()
            if (areWeEditing == true) {
                ///Update CoreData instead of creating
                updateData()
                segueHome.dataSource.collection[editingIndex] = returnData
                segueHome.workoutsTableView.reloadData()
                segueHome.workoutsTableView.layoutIfNeeded()
//                segueHome.fetchData()
                return
            }
            else {
                
                returnData.name = dataSource.workoutName
                returnData.sets = dataSource.collection
                segueHome.dataSource.collection.append(returnData)

                
                segueHome.workoutsTableView.reloadData()
                buildReturnData()
//                segueHome.fetchData()
            }
        }
        else {
            if (areWeEditing == true) {
                ///Update CoreData instead of creating
                updateData()
//                segueHome.fetchData()
                
            }
            else {
//                updateData()
                
//                segueHome.fetchData()
            }
            let segueHome = segue.destination as! WorkoutViewController
            var wvcSample = [Exercise]()
            
            var totalTime = 0
            for s in dataSource.collection  {
                for e in s.exercises {
                    wvcSample.append(e)
                    let components = e.time.split { $0 == ":" } .map { (x) -> Int in return Int(String(x))! }

                    totalTime += (components[0] * 60)
                    totalTime += components[1]
                }
            }
            
            segueHome.sample = wvcSample
            segueHome.timeInSeconds = totalTime
        }
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        performSegue(withIdentifier: "unwindHome", sender: self)
    }
    
    func updateData(){
        returnData.name = dataSource.workoutName
        returnData.sets = dataSource.collection
        let myWorkouts = MyWorkouts(workouts: [returnData])
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Workout")
//        fetchRequest.predicate = NSPredicate(format: "range = %@", "Mark:1")
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectUpdate = test[editingIndex] as! NSManagedObject ///#FIXME: Still going into editing in New
            objectUpdate.setValue(myWorkouts, forKeyPath: "myWorkout")
//            objectUpdate.setValue("newmail", forKey: "email")
//            objectUpdate.setValue("newpassword", forKey: "password")
            do{
                try managedContext.save()
            }
            catch
            {
                
            }
        }
        catch
        {
            
        }
        
    }
    
    func buildReturnData() -> Void { //TODO: impkement
        var sets = [SetWithExercises]()
        
        returnData.name = dataSource.workoutName
        returnData.sets = dataSource.collection
        
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "Workout", in: managedContext)!
        
        let router = NSManagedObject(entity: userEntity, insertInto: managedContext) as! Workout
        
        let myWorkouts = MyWorkouts(workouts: [returnData])
        router.setValue(myWorkouts, forKeyPath: "myWorkout")

        
        do {
            try managedContext.save()
            
            
        } catch let error as NSError {
            
        }
        
        ///Iterate IndexPath.row times   pending DELETE
        
//
//        var time: Double  //iterate total time in nested loops below
//        for i in (0..<setupTable.numberOfRows(inSection: 1)) {  ///loops thru Sets and their Exercises
//
//            let setCell = setupTable.cellForRow(at: IndexPath(row: i, section: 1)) as! SetTableViewCell
//            print(setCell.dataSource)
//            var exercises = [Exercise]()
//
//            for j in (0..<setCell.exerciseTable.numberOfRows(inSection: 0)) {
//                let exerciseCell = setCell.exerciseTable.cellForRow(at: IndexPath(row: j, section: 0)) as! ExerciseTableViewCell
//
//                let name = exerciseCell.exerciseTitle.text ?? "NO_EXERC_NAME_GIVEN"
//                let indiv_time = 0.0
//                ///For time, we need to take mm:ss and turn it into digestable time format
//                _ = exerciseCell.exerciseTime.text!.firstIndex(of: ":")
//                ///TODO: slice the first two characters for mintutesToSeconds: Double
//                ///TODO: slice the last two characters for seconds: Double
//                ///TODO: convert minutesToSeconds, add to seconds, and return as time.
//                exercises.append(Exercise(name: name, time: "indiv_time"))
//                ///TODO: append overall time
//
//            }
//
//            sets.append(SetWithExercises(exercises: exercises))
//        }
//
///        return MyWorkout(name: name, time: time, sets: sets)
        
        
//        return MyWorkout(name: dataSource.workoutName , time: 0)
    }
    
    
    @IBAction func syncTitles(_ sender: UITextField) {
        navBarTitle.title = sender.text ?? "New Workout"
        if(self.changeMeView.alpha > 0.9) {
            
            UIView.animate(withDuration: 0.45) {
                self.changeMeView.alpha = 0.0
            }
        }
        else if (sender.text == "") {
            navBarTitle.title = "New Workout"
            UIView.animate(withDuration: 0.45) {
                self.changeMeView.alpha = 1.0
            }

        }
    }
    
//    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath
//    {
//      if sourceIndexPath.section == proposedDestinationIndexPath.section
//      {
//        return proposedDestinationIndexPath
//      } else {
//        return sourceIndexPath
//      }
//    }
    
    
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
//        performSegue(withIdentifier: "unwindSave", sender: self)
//        setupTable.reloadData()
//        updateData()
//        buildReturnData()
//        ///FIXME: ^^ Doesn't update properly.
        performSegue(withIdentifier: "unwindHome", sender: self)
        
        
        ///Animates shake for Change Me
        Animations.requireUserAtencion(on: changeMeView)
        UIView.animate(withDuration: 0.5) {
            self.changeMeView.backgroundColor = .systemRed
        }
        UIView.animate(withDuration: 0.5) {
            self.changeMeView.backgroundColor = .systemYellow
        }
        ///
        

    }
    
    @IBAction func editTimeTextField(_ sender: Any) {
        
    }
    
    @IBAction func ss(_ sender: Any) {
    }
    
    
    
    
    
}



class Animations {
    static func requireUserAtencion(on onView: UIView) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.1
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: onView.center.x - 5, y: onView.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: onView.center.x + 10, y: onView.center.y))
        onView.layer.add(animation, forKey: "position")
    }
}
