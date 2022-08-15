//
//  MyTableViewCell.swift
//  SetTrack
//
//  Created by Anant Singh on 8/10/21.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var dumbell: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var exerciseLbl: UILabel!
    @IBOutlet weak var setsLbl: UILabel!
    @IBOutlet weak var staticXLbl: UILabel!
    @IBOutlet weak var repsLbl: UILabel!
    @IBOutlet weak var weightsLbl: UILabel!
    @IBOutlet weak var staticPoundsLbl: UILabel!
    @IBOutlet weak var startWorkoutBtn: UIButton!
    
    
    @IBOutlet weak var startBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with workout: Workout){
        if let date = workout.value(forKey: "date") as? Date,
           let exercise = workout.value(forKey: "exercise") as? String,
           let numbers = workout.value(forKey: "numbers") as? Double,
           let title = workout.value(forKey: "title") as? String{
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .none
            dateFormatter.locale = Locale.current
            let dateString = dateFormatter.string(from: date)
            
            dateLbl?.text = dateString
            exerciseLbl?.text = exercise
            weightsLbl?.text = numbers.description
            titleLbl?.text = title
            
            
        }
    }

}
