//
//  InWorkoutViewController.swift
//  SetTrack
//
//  Created by Anant Singh on 8/5/21.
//

import UIKit

class InWorkoutViewController: UIViewController {
    
    @IBOutlet var swiper: UISwipeGestureRecognizer!
    @IBOutlet weak var counterLbl: UILabel!
    @IBOutlet var buttons: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loadingthe view.
        swiper.direction = .left
        counterLbl?.text = "0"
    }
    
    
    @IBAction func onSwiper(_ sender: UISwipeGestureRecognizer) {
        counterLbl.backgroundColor = UIColor.systemGreen
    }
    
    
    var count = 0 {
        willSet{
            counterLbl?.text = newValue.description
        }
    }
    
    @IBAction func clicked(_ sender: UIButton) {
        count = count + 1
        
    }
    
    @IBAction func onDone(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)

    }
    
    @IBAction func onReset(_ sender: Any) {
        count = 0
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
