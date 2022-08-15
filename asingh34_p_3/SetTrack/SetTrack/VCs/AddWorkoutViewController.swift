//
//  AddWorkoutViewController.swift
//  SetTrack
//
//  Created by Anant Singh on 8/5/21.
//

import UIKit
import CoreData

class AddWorkoutViewController: UIViewController {

    // MARK: - UIelements
    //title field
    @IBOutlet weak var titleTextFld: UITextField!
    //exercise picker
    @IBOutlet weak var exercisePkr: UIPickerView!
    //setting number of sets stack
    @IBOutlet weak var setSetLbl: UILabel!
    @IBOutlet weak var setStpr: UIStepper!
    @IBOutlet weak var setDscr: UILabel!
    //setting number of reps stack
    @IBOutlet weak var setRepLbl: UILabel!
    @IBOutlet weak var repStpr: UIStepper!
    @IBOutlet weak var repDescr: UILabel!
    //setting timer stack
    @IBOutlet weak var setTimerLbl: UILabel!
    @IBOutlet weak var timerStpr: UIStepper!
    @IBOutlet weak var timerDescr: UILabel!
    //setting weight stack
    @IBOutlet weak var setWeightlLbl: UILabel!
    @IBOutlet weak var weightStpr: UIStepper!
    @IBOutlet weak var weightDescr: UILabel!
    
    //Cancel add buttons
    @IBOutlet weak var strtWrktBtn: UIButton!
    @IBOutlet weak var cnclWrktBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set stack
        setSetLbl?.text = NSLocalizedString("str_set", comment: "")
        setStpr?.value = 0
        setDscr?.text = "0"
        //reps stack
        setRepLbl?.text = NSLocalizedString("str_rep", comment: "")
        repStpr?.value = 0
        repDescr?.text = "0"
        //timer stack
        setTimerLbl?.text = NSLocalizedString("str_timer", comment: "")
        timerStpr?.value = 1.30
        timerDescr?.text = "1:30"
        //weight stack
        setWeightlLbl?.text = NSLocalizedString("str_weight", comment: "")
        weightStpr?.value = 0.0
        weightDescr?.text = "0.0"
    }
    // MARK: - Steppers
    
    //sets
    var sets = 0 {
        willSet{
            setDscr?.text = newValue.description
        }
    }
    
    @IBAction func onSetStepper(_ sender: UIStepper) {
        sets = Int(sender.value)
    }
    //reps
    var reps = 0{
        willSet{
            repDescr?.text = newValue.description
        }
    }
   
    @IBAction func onRepStepper(_ sender: UIStepper) {
        reps = Int(sender.value)
    }
    //timer
    var timer = 1.30{
        willSet{
            timerDescr?.text = newValue.description
        }
    }
    
    @IBAction func onTimerStepper(_ sender: UIStepper) {
        timer = Double(sender.value)
        
    }
    //weight
    var weight = 0.0{
        willSet{
            weightDescr?.text = newValue.description
        }
    }
    @IBAction func onWeightStepper(_ sender: UIStepper) {
        weight = Double(sender.value)
    }
    

    @IBAction func onCancel(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    
    //this should send you to the next screen but also add the entry to the table
    @IBAction func onStart(_ sender: Any) {
        if let title = titleTextFld?.text{
            
            
            let context = AppDelegate.cdContext
            if let entity = NSEntityDescription.entity(forEntityName: "Workout", in: context){
                let workout = NSManagedObject(entity: entity, insertInto: context)
                workout.setValue(title, forKeyPath: "title")
                workout.setValue(pickerViewData[exercisePkr.selectedRow(inComponent:0)], forKey: "exercise")
                workout.setValue(NSDate(), forKey: "date")
                workout.setValue(Int(weightStpr.value), forKey: "numbers")
               
                    do{
                        try context.save()
                    }catch let error as NSError{
                        print ("could not save item. \(error), \(error.userInfo)")
                    }
                NotificationCenter.default.post(name: Notificaitons.workoutAdded, object: nil)
                self.presentingViewController?.dismiss(animated: true)
                
            }
            
            
        }

    }
}
 let pickerViewData = [NSLocalizedString("str_bench", comment: ""),NSLocalizedString("str_squat", comment: ""),NSLocalizedString("str_dead", comment: "")]

extension AddWorkoutViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewData[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}
