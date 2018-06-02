//
//  PulseViewController.swift
//  Eat
//
//  Created by Alek Matthiessen on 5/31/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit
import UserNotifications

var goal1 = String()
var goal2 = String()
var goal3 = String()
var goal4 = String()
var goal5 = String()
var goal6 = String()
var goal7 = String()

var today1 = String()
var today2 = String()
var today3 = String()
var today4 = String()
var today5 = String()
var today6 = String()
var today7 = String()

var tapped = Bool()
class PulseViewController: UIViewController {

    @IBAction func tapGoals(_ sender: Any) {
        
        if tapped {
        button1.setTitle(goal1, for: .normal)
        button2.setTitle(goal1, for: .normal)
        button3.setTitle(goal1, for: .normal)
        button4.setTitle(goal1, for: .normal)
        button5.setTitle(goal1, for: .normal)
        button6.setTitle(goal1, for: .normal)
        button7.setTitle(goal1, for: .normal)
            
            tapped = false
            
        } else {
            
            tapped = true
        }
        
    }
    
    func loadtodaysvalues() {
        
        button1.setTitle(today1, for: .normal)
        button2.setTitle(today2, for: .normal)
        button3.setTitle(today3, for: .normal)
        button4.setTitle(today4, for: .normal)
        button5.setTitle(today5, for: .normal)
        button6.setTitle(today6, for: .normal)
        button7.setTitle(today7, for: .normal)
    }
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()

        // Do any additional setup after loading the view.
        
        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in
            
            DispatchQueue.main.async {
                
                self.performSegue(withIdentifier: "PulseToHome", sender: self)
                
            }
            
        } else {
            
            
            // Do any additional setup after loading the view.
            
            let date = Date()
            let calendar = Calendar.current
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yy"
            todaysdate =  dateFormatter.string(from: date)
            
            uid = (Auth.auth().currentUser?.uid)!
            
        }
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
