//
//  WorkoutListTableViewController.swift
//  SetTrack
//
//  Created by Anant Singh on 8/5/21.
//

import UIKit
import CoreData
class WorkoutListTableViewController: UITableViewController {
    
    @IBOutlet var swipeDown: UISwipeGestureRecognizer!
    
    var workouts: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
        swipeDown.direction = .down
        readData()
    }

    
    @IBAction func onSwipeDown(_ sender: UISwipeGestureRecognizer) {
        print("swipe recognized")
        readData()
    }
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return workouts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell") as? MyTableViewCell else{
                fatalError("Expected MyTableViewCell")
            }
        
        if let workout = workouts[indexPath.row] as? Workout {
            cell.update(with: workout)
        }
        return cell
    }
    

    

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let workout = workouts[indexPath.row] as? Workout, let title = workout.title {
                deletionAlert(title: title, completion: { _ in
                    self.deleteItem(workout: workout)
                })
            }
        }
    }
    func deleteItem(workout: Workout) {
        let context = AppDelegate.cdContext
        if let _ = workouts.firstIndex(of: workout)  {
            context.delete(workout)
            do {
                try context.save()
            } catch let error as NSError {
                print("Could not delete the item. \(error), \(error.userInfo)")
            }
        }
        readData()
    }
    
    
    func deletionAlert(title: String, completion: @escaping (UIAlertAction) -> Void) {
        
        let alertMsg = "delete \(title)? Data will be lost."
        let alert = UIAlertController(title: "Warning", message: alertMsg, preferredStyle: .actionSheet)
    
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: completion)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:nil)
        
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        
        alert.popoverPresentationController?.permittedArrowDirections = []
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)

        present(alert, animated: true, completion: nil)
    }
        
    func readData() {
        let context = AppDelegate.cdContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Workout")
        do {
            workouts = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch requested item. \(error), \(error.userInfo)")
        }
        tableView.reloadData()
    }
    
    
    @IBAction func onEdit(_ sender: Any) {
        setEditing(!isEditing, animated: true)

    }
    
   

}
public struct Notificaitons{
    public static let workoutAdded = Notification.Name(rawValue: "WorkoutAddedNotification")
    public static let privacyAccepted = Notification.Name(rawValue: "PrivacyAcceptedNotification")
}



    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    

