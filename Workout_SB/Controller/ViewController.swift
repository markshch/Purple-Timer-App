//
//  ViewController.swift
//  Workout_SB
//
//  Created by Mark ⠀ on 6/14/21.
//

///### Initial view controller

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet var newButton: UIBarButtonItem!
    @IBOutlet var search: UISearchBar!
    @IBOutlet var newWorkoutButton: UIButton!
    
    var indexAsInt = -1
    
    @IBOutlet var navBar: UINavigationBar!
    @IBOutlet var secondsBarButtonItem: UIBarButtonItem!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    @IBOutlet var workoutsTableView: UITableView!
    var dataSource: MyWorkoutDataSource!
    var data = [MyWorkout]() {
        didSet {
            
        }
    }
    public var filteredResults: [MyWorkout] = []
    public var searching = false
//    let searchController = UISearchController(searchResultsController: nil)
//    var isSearchBarEmpty: Bool {
//      return searchController.searchBar.text?.isEmpty ?? true
//    }
    
    var firstLoad = true
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Segue to the second view controller
//        self.performSegue(withIdentifier: "yourSegue", sender: self)
        ///#PENDING DELETE    08-02-21
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return filteredResults.count
        } else {
             return data.count
        }
            
    }
    
    func deleteEntries() {
        do {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedObjectContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Workout")
            let request: NSBatchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            try managedObjectContext.execute(request)
            try managedObjectContext.save()
            print("Deleted.")
        } catch let error {
            print("Not Deleted.")
            print(error.localizedDescription)
        }
    }
    
    @objc func dissMissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
//        deleteEntries()
        search.delegate = self
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dissMissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
        
        
        
        
        workoutsTableView.delegate = self
//        /**/  data.append(MyWorkout(name: "Super Abs", time: 0)) /// Pending delete
        let dataSource = MyWorkoutDataSource(collection: data)
        self.dataSource = dataSource
        workoutsTableView.dataSource = self.dataSource
        
        newWorkoutButton.backgroundColor = .systemGray5
        newWorkoutButton.layer.cornerRadius = 9
        
        let view = UIView()
        let button = UIButton(type: .custom)
        button.semanticContentAttribute = .forceLeftToRight
        button.setImage(UIImage(named: "Seconds_LOGO_SOLID_SMALL"), for: .normal)
        button.setTitle("  Purple", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        button.setTitleColor(.label, for: .normal)
        button.sizeToFit()
        view.addSubview(button)
        view.frame = button.bounds
        secondsBarButtonItem.customView = view
        
        
        
        if (firstLoad == true) {
        fetchData()
        }
        else {
            firstLoad = false
        }
        
        
        

    }
    
    
//    
//    func filterContentForSearchText(_ searchText: String, category: Any? = nil) {
//      filteredResults = data.filter { (workout: MyWorkout) -> Bool in
//        return workout.name.lowercased().contains(searchText.lowercased())
//      }
//      
//     workoutsTableView.reloadData()
//    }
    
    
    
    func fetchData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Workout")
        
        do {
            let result = try managedContext.fetch(fetchRequest)

            var i = 0
            for data in result as! [NSManagedObject] {
                let workout = data.value(forKey: "myWorkout") as! MyWorkouts
                
                
                dataSource.collection.append(workout.workouts[0])
                i = i + 1
            }
            
            
            let cmsg = try result.first as? Workout
//            print("first: \(String(describing: cmsg.myWorkout))")
            
        } catch {
            
            print("Failed")
        }
        
        
    }
    
    
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
//        workoutsTableView.reloadData()
    }
    
    
    @IBAction func Go(_ sender: UIButton) {
//        let s = sender.superview?.superview?.superview as! UITableViewCell
//        let ss = s.superview as! UITableView
//        let index = ss.indexPath(for: s)
//        indexAsInt = index!.item
        
//        performSegue(withIdentifier: "Go", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { ///Edit Workout
//        let vc = segue.destination as? CreateWorkoutViewController
        if (segue.identifier == "editWorkout") {
            let vc = segue.destination as? CreateWorkoutViewController
//            vc?.sample
            var s = sender as! UIButton
            let ss = s.superview?.superview?.superview as! WorkoutTableViewCell
            let index = workoutsTableView.indexPath(for: ss)
            
            vc?.sample = dataSource.collection[index!.item].sets
            
            vc?.editingIndex = index!.item
            
            let dataSource1 = SetWithExercisesDataSource(sets: dataSource.collection[index!.item].sets)
            
            vc?.dataSource = dataSource1
            vc?.dataSource.workoutName = dataSource.collection[index!.item].name
            vc?.changeMeView.alpha = 0.0
            vc?.areWeEditing = true
            
            
        }
        else if (segue.identifier == "Go") {
            
            let segueHome = segue.destination as! WorkoutViewController
//            let ds = dataSource.collection[indexAsInt]
            
            var s = sender as! UIButton
            let ss = s.superview?.superview?.superview as! WorkoutTableViewCell
            let index = workoutsTableView.indexPath(for: ss)
            
//            vc?.sample = dataSource.collection[index!.item].sets
            ///#FIXME: Pass on exercises.
            var wvcSample = [Exercise]()
            
            var totalTime = 0
            for s in dataSource.collection[index!.item].sets  {
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
    
    ///Add swipe-left to delete

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        var actions = [UIContextualAction]()
        

        let delete = UIContextualAction(style: .destructive, title: nil) { (_, _, completion) in
            
            
            let refreshAlert = UIAlertController(title: "Are you sure?", message: "You cannot undo this action.", preferredStyle: UIAlertController.Style.actionSheet)

            refreshAlert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action: UIAlertAction!) in

                self.dataSource.collection.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                self.deleteData(at: indexPath.row)
                completion(true)
            }))

            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                //do nothing
                return
            }))

            self.present(refreshAlert, animated: true, completion: nil)
            
            completion(true)


        }

        let largeConfig = UIImage.SymbolConfiguration(pointSize: 17.0, weight: .bold, scale: .large)
        delete.image = UIImage(systemName: "trash", withConfiguration: largeConfig)?.withTintColor(.white, renderingMode: .alwaysTemplate).addBackgroundCircle(.systemRed)
        delete.backgroundColor = .systemBackground
        delete.title = "Delete"

        actions.append(delete)

        let config = UISwipeActionsConfiguration(actions: actions)
        config.performsFirstActionWithFullSwipe = true

        return config
    }

    /// --
    
    func deleteData(at row: Int){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Workout")
        
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectToDelete = test[row] as! NSManagedObject
            managedContext.delete(objectToDelete)
            
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
    


    
    
    


}


//
//extension ViewController: UISearchResultsUpdating {
//  func updateSearchResults(for searchController: UISearchController) {
//    let searchBar = searchController.searchBar
//    filterContentForSearchText(searchBar.text!)
//
//  }
//}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText != "") {searchBar.setShowsCancelButton(true, animated: true)
            searchBar.showsCancelButton = true}
        else {
            searchBar.setShowsCancelButton(false, animated: true)
            searchBar.showsCancelButton = false
        }
        dataSource.filteredResults = dataSource.collection.filter {
            var ret = false
            ret = $0.name.lowercased().prefix(searchText.count) == searchText.lowercased()
            
            for s in $0.sets {
                for e in s.exercises {
                    if e.name.lowercased() == searchText.lowercased() {
                        ret = true
                    }
                }
            }
            
            return ret
            
        }
        dataSource.searching = true
        workoutsTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dataSource.searching = false
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.showsCancelButton = false
        workoutsTableView.reloadData()

    }
}




