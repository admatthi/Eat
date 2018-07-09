//
//  WorkoutOptionsViewController.swift
//  Eat
//
//  Created by Alek Matthiessen on 6/17/18.
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

let bigblack = UIColor(red:0.18, green:0.18, blue:0.24, alpha:1.0)

var selectedcategory = String()
var activityids = [String]()
var activitylabels = [String:String]()
var finished = [String:String]()
var tags = [String:String]()


var selectedtask = String()
var selectedtaskid = String()

class WorkoutOptionsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tappeople: UIButton!
    @IBOutlet weak var evening: UITextField!
    @IBOutlet weak var wins: UITextField!
    @IBOutlet weak var lessons: UITextField!
    @IBOutlet weak var morning: UITextField!
    @IBOutlet weak var targets2: UITextField!
    @IBOutlet weak var targets1: UITextField!
    @IBOutlet weak var tapcareer: UIButton!
    @IBOutlet weak var tapbody: UIButton!
    
    @IBOutlet weak var taphappiness: UIButton!
    @IBOutlet weak var taplabel: UILabel!
    @IBOutlet weak var bottomlabel: UILabel!
    @IBAction func tapHappiness(_ sender: Any) {
        
        happinesstapped()
    }
    @IBAction func changes1(_ sender: UITextField) {
        
        if targets1.text != "" {
            
        ref?.child("Users").child(uid).child(selectedcategory).child(todaysdate).updateChildValues(["Targets1" : targets1.text!, "Completed" : "False", "Tag" : ""])

        }
        
    }

    @IBAction func changes2(_ sender: UITextField) {
        
        if targets2.text != "" {
            
            ref?.child("Users").child(uid).child(selectedcategory).child(todaysdate).updateChildValues(["Targets2" : targets2.text!, "Completed" : "False", "Tag" : ""])
            
        }
    }
    
    @IBAction func changes3(_ sender: UITextField) {
        
        if morning.text != "" {
            
            ref?.child("Users").child(uid).child(selectedcategory).child(todaysdate).updateChildValues(["morning" : morning.text!, "Completed" : "False", "Tag" : ""])
            
        }
        
    }
    
    @IBAction func changes4(_ sender: UITextField) {
        
        if lessons.text != "" {
            
            ref?.child("Users").child(uid).child(selectedcategory).child(todaysdate).updateChildValues(["lessons" : lessons.text!, "Completed" : "False", "Tag" : ""])
            
        }
    }
    

    
    @IBAction func changes5(_ sender: UITextField) {
        
        if wins.text != "" {
            
            ref?.child("Users").child(uid).child(selectedcategory).child(todaysdate).updateChildValues(["wins" : wins.text!, "Completed" : "False", "Tag" : ""])
            
        }
        
    }
 
    @IBAction func changes6(_ sender: UITextField) {
        
        if evening.text != "" {
            
            ref?.child("Users").child(uid).child(selectedcategory).child(todaysdate).updateChildValues(["evening" : evening.text!, "Completed" : "False", "Tag" : ""])
            
        }
    }
    

    
    
    @IBOutlet weak var goallabel: UILabel!
    @IBAction func tapPeople(_ sender: Any) {
        
        peopletapped()
    }
    @IBAction func tapBody(_ sender: Any) {
        
        bodytapped()
    }
    @IBAction func tapCareer(_ sender: Any) {
        
        careertapped()
    }
    
    func bodytapped() {
        
        tapbody.alpha = 1
        tapcareer.alpha = 0.5
        tappeople.alpha = 0.5
        taphappiness.alpha = 0.5

        selectedcategory = "Health"
        
        queryforlastopened  { () -> () in
            
            self.goallabel.text = bodymonthlygoal
            
            self.seeifnewday()
            
        }
    }
    
    func careertapped() {
        
        tapcareer.alpha = 1
        tapbody.alpha = 0.5
        tappeople.alpha = 0.5
        taphappiness.alpha = 0.5

        selectedcategory = "Wealth"
        
        queryforlastopened  { () -> () in
            
            self.goallabel.text = careermonthlygoal
            
            self.seeifnewday()
            
        }
    }
    
    func peopletapped() {
        
        tappeople.alpha = 1
        tapbody.alpha = 0.5
        tapcareer.alpha = 0.5
        taphappiness.alpha = 0.5

        selectedcategory = "Love"
        
        queryforlastopened  { () -> () in
            
            self.goallabel.text = peoplemonthlygoal
            
            self.seeifnewday()
            
        }
    }
    
    func happinesstapped() {
        
        tappeople.alpha = 0.5
        tapbody.alpha = 0.5
        tapcareer.alpha = 0.5
        taphappiness.alpha = 1
        
        selectedcategory = "Happiness"
        
        queryforlastopened  { () -> () in
            
            self.goallabel.text = happinessmonthlygoal
            
            self.seeifnewday()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
 
        taplabel.layer.cornerRadius = 5.0
        taplabel.layer.masksToBounds = true
        
        self.becomeFirstResponder() // To get shake gesture

        // Do any additional setup after loading the view.
        
        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in

            DispatchQueue.main.async {
//                newuser = true

                self.performSegue(withIdentifier: "HomeToWorkouts", sender: self)
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

            bodytapped()

            targets1.delegate = self
        }
//
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    var lastopened = String()
    
    func queryforlastopened(completed: @escaping (() -> ()) ) {
        
        ref?.child("Users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in

            var value = snapshot.value as? NSDictionary

            if var activityvalue = value?["LastOpened"] as? String {

                self.lastopened = activityvalue

            }
            
            if var activityvalue1 = value?["BodyMonthlyGoal"] as? String {
                
                bodymonthlygoal = activityvalue1
                
            }
            
            if var activityvalue2 = value?["PeopleMonthlyGoal"] as? String {
                
                peoplemonthlygoal = activityvalue2
                
            }
            if var activityvalue4 = value?["HappinessMonthlyGoal"] as? String {
                
                happinessmonthlygoal = activityvalue4
                
            }
            
            if var activityvalue3 = value?["CareerMonthlyGoal"] as? String {
                
                careermonthlygoal = activityvalue3
                
                completed()

            }

            
        })
    
    }
    
    func seeifnewday() {
        
        if lastopened == todaysdate {
            
            thedate = todaysdate
            
            self.queryforworkoutinfo()
            
        } else {
            

            let calendar = Calendar.current
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yy"
            yesterdaydate =  dateFormatter.string(from: Date().yesterday)
            
            
        }
    }
    
    var yesterdaydate = String()
    
    var thedate = String()

    
    func queryforworkoutinfo() {
        
        var functioncounter = 0
        
            ref?.child("Users").child(uid).child(selectedcategory).child(thedate).observeSingleEvent(of: .value, with: { (snapshot) in

                var value = snapshot.value as? NSDictionary
                
                if var activityvalue = value?["Targets1"] as? String {
                    
                    self.targets1.text = activityvalue
                    
                    
                }
                
                
                if var activityvalue = value?["Targets2"] as? String {
                    
                    self.targets2.text = activityvalue
                    
                    
                }
                
                
                if var activityvalue = value?["morning"] as? String {
                    
                    self.morning.text = activityvalue
                    
                    
                }
                
                if var activityvalue = value?["lessons"] as? String {
                    
                    self.lessons.text = activityvalue
                    
                    
                }
                
                if var activityvalue = value?["wins"] as? String {
                    
                    self.wins.text = activityvalue
                    
                    
                }
                
                if var activityvalue = value?["evening"] as? String {
                    
                    self.evening.text = activityvalue
                    
                    
                }
                
    
            })
            
            
    }
    


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
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

extension Date {
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return tomorrow.month != month
    }
}
