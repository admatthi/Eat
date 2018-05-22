//
//  EViewController.swift
//  Eat
//
//  Created by Alek Matthiessen on 5/20/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import FBSDKCoreKit

class EViewController: UIViewController {

    @IBOutlet weak var tapbutton1: UIButton!
    @IBOutlet weak var tapbutton2: UIButton!
    @IBOutlet weak var tapbutton3: UIButton!
    @IBOutlet weak var tapbutton4: UIButton!
    
    @IBAction func tapButton1(_ sender: Any) {
        
        tapbutton1.alpha = 1
        tapbutton2.alpha = 0.5
        tapbutton3.alpha = 0.5
    }
    @IBAction func tapButton2(_ sender: Any) {
        
        tapbutton2.alpha = 1
        tapbutton1.alpha = 0.5
        tapbutton3.alpha = 0.5
    }
    @IBAction func tapButton3(_ sender: Any) {
        
        tapbutton3.alpha = 1
        tapbutton2.alpha = 0.5
        tapbutton1.alpha = 0.5
    }
    @IBAction func tapButton4(_ sender: Any) {
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FBSDKAppEvents.logEvent("Fifth Screen")
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

