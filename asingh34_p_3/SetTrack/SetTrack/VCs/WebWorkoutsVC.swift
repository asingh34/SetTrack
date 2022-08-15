//
//  WebWorkoutsVC.swift
//  SetTrack
//
//  Created by Anant Singh on 8/11/21.
//

import Foundation
import UIKit
import WebKit

class WebWorkoutsVC: UIViewController {
    
    @IBOutlet weak var urlField: UITextField!
    @IBOutlet weak var webSscreen: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlField?.text = "https://www.freetrainers.com/exercise/muscles/"
        loadUrl()
    }
    
    func loadUrl(){
        if let website = urlField.text,
           let url = URL(string: website){
            let req = URLRequest(url:url)
            webSscreen.load(req)
        }
    }
    
    @IBAction func onSearch(_ sender: Any) {
        loadUrl()
    }
    
    
}
