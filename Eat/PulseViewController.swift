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
var goal8 = String()
var goal9 = String()
var goal10 = String()
var goal11 = String()
var goal12 = String()
var goal13 = String()
var caloriesgoal = String()

var todayscalories = String()
var today1 = String()
var today2 = String()
var today3 = String()
var today4 = String()
var today5 = String()
var today6 = String()
var today7 = String()
var today8 = String()
var today9 = String()
var today10 = String()
var today11 = String()
var today12 = String()
var today13 = String()

var viewingtoday = Bool()
var tapped = Bool()

var newuser = Bool()

class PulseViewController: UIViewController {

    @IBOutlet weak var goallabel: UILabel!
    @IBAction func tapGoals(_ sender: Any) {
        
        switchtogoals()
        
    }
    
    @IBOutlet weak var remaininglabel: UILabel!
    func loadtodaysvalues() {
        
        calories.text = todayscalories
        n1.text = "\(today1)g"
        n2.text = "\(today2)g"
        n3.text = "\(today3)g"
        n4.text = "\(today4)mg"
        n5.text = "\(today5)mg"
        n6.text = "\(today6)mg"
        n7.text = "\(today7)mg"
        n8.text = "\(today8)g"
        n9.text = "\(today9) IU"
        n10.text = "\(today10)ug"
        n11.text = "\(today11)mg"
        n12.text = "\(today12) IU"

        remaininglabel.text = String(Int(2000 - Double(todayscalories)!))
        
        
    }
    
    @IBOutlet weak var calories: UILabel!
    func switchtogoals() {
        
        if viewingtoday {
        calories.text = caloriesgoal
        n1.text = "\(goal1)g"
        n2.text = "\(goal2)g"
        n3.text = "\(goal3)g"
        n4.text = "\(goal4)mg"
        n5.text = "\(goal5)mg"
        n6.text = "\(goal6)mg"
        n7.text = "\(goal7)mg"
        n8.text = "\(goal8)g"
        n9.text = "\(goal9) IU"
        n10.text = "\(goal10)ug"
        n11.text = "\(goal11)mg"
        n12.text = "\(goal12) IU"
            
            viewingtoday = false
        } else {
            
            loadtodaysvalues()
            
            viewingtoday = true
        }

    }

    
    func defaulttoday() {
        
        todayscalories = "0"
        today1 = "0"
        today2 = "0"
        today3 = "0"
        today4 = "0"
        today5 = "0"
        today6 = "0"
        today7 = "0"
        today8 = "0"
        today9 = "0"
        today10 = "0"
        today11 = "0"
        today12 = "0"
    }
    
    func defaultgoals() {
        
        caloriesgoal = "2000"
        goal1 = "50"
        goal2 = "300"
        goal3 = "65"
        goal4 = "3500"
        goal5 = "2400"
        goal6 = "300"
        goal7 = "15"
        goal8 = "25"
        goal9 = "400"
        goal10 = "70"
        goal11 = "18"
        goal12 = "5000"
    }
    @IBOutlet weak var n1: UILabel!
    @IBOutlet weak var n2: UILabel!
    @IBOutlet weak var n3: UILabel!
    @IBOutlet weak var n4: UILabel!
    @IBOutlet weak var n5: UILabel!
    @IBOutlet weak var n6: UILabel!
    @IBOutlet weak var n7: UILabel!
    @IBOutlet weak var n8: UILabel!
    @IBOutlet weak var n9: UILabel!
    @IBOutlet weak var n10: UILabel!
    @IBOutlet weak var n11: UILabel!
    @IBOutlet weak var n12: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()

        // Do any additional setup after loading the view.
        
        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in
            
            DispatchQueue.main.async {
                newuser = true

                self.performSegue(withIdentifier: "PulseToPhoto", sender: self)
            }
            
        } else {
            
            newuser = false
            // Do any additional setup after loading the view.
            
            let date = Date()
            let calendar = Calendar.current
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yy"
            todaysdate =  dateFormatter.string(from: date)
            
            uid = (Auth.auth().currentUser?.uid)!
            
            viewingtoday = true
            defaulttoday()
            defaultgoals()
            loadtodaysvalues()
            queryfortodaysvalues()
        }
    }
    
    func queryfortodaysvalues() {
        
ref?.child("OurUsers").child(uid).child(todaysdate).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if var activityvalue = value?["Calories"] as? String {
                
                todayscalories = activityvalue
                self.loadtodaysvalues()
            }
            
            if var activityvalue = value?["Protein"] as? String {
                
                today1 = activityvalue
                self.loadtodaysvalues()
            }
            
            if var activityvalue = value?["Carbs"] as? String {
                
                today2 = activityvalue
                self.loadtodaysvalues()
            }
            
            if var activityvalue = value?["Fats"] as? String {
                
                today3 = activityvalue
                self.loadtodaysvalues()
            }
            if var activityvalue = value?["Potassium"] as? String {
                
                today4 = activityvalue
                self.loadtodaysvalues()
            }
            if var activityvalue = value?["Sodium"] as? String {
                
                today5 = activityvalue
                self.loadtodaysvalues()
                
            }
            if var activityvalue = value?["Cholesterol"] as? String {
                
                today6 = activityvalue
                self.loadtodaysvalues()
            }
            if var activityvalue = value?["Zinc"] as? String {
                
                today7 = activityvalue
                self.loadtodaysvalues()
            }
            if var activityvalue = value?["Fiber"] as? String {
                
                today8 = activityvalue
                self.loadtodaysvalues()
            }
            if var activityvalue = value?["Viamin D"] as? String {
                
                today9 = activityvalue
                self.loadtodaysvalues()
            }
            if var activityvalue = value?["Selenium"] as? String {
                
                today10 = activityvalue
                self.loadtodaysvalues()
            }
            if var activityvalue = value?["Iron"] as? String {
                
                today11 = activityvalue
                self.loadtodaysvalues()
            }
            if var activityvalue = value?["Vitamin A"] as? String {
                
                today12 = activityvalue
                self.loadtodaysvalues()
            }
            
        })
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
