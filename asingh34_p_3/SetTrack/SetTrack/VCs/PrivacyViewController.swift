//
//  PrivacyViewController.swift
//  SetTrack
//
//  Created by Anant Singh on 8/5/21.
//

import UIKit

class PrivacyViewController: UIViewController {
    
    @IBOutlet weak var privacyLbl: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        privacyLbl.text = NSLocalizedString("str_privacy", comment: "")
    
    }
    
    @IBAction func onAccept(_ sender: UIButton) {
        acceptAlert(completion: {_ in
            self.presentingViewController?.dismiss(animated: true)
        })
        NotificationCenter.default.post(name: Notificaitons.privacyAccepted, object: nil)


    }
    
    @IBAction func onCancel(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true)


    }
    
    
    func acceptAlert(completion: @escaping (UIAlertAction) -> Void) {
        
        let alertMsg = "Accept privacy Policy?"
        let alert = UIAlertController(title: "Privacy Policy", message: alertMsg, preferredStyle: .actionSheet)
    
        let acceptAction = UIAlertAction(title: "Accept", style: .destructive, handler: completion)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:nil)
        
        alert.addAction(acceptAction)
        alert.addAction(cancelAction)
        
        alert.popoverPresentationController?.permittedArrowDirections = []
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)

        present(alert, animated: true, completion: nil)
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
