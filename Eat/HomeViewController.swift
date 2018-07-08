//
//  HomeViewController.swift
//  Eat
//
//  Created by Alek Matthiessen on 7/7/18.
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

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tappeople: UIButton!
    @IBOutlet weak var tapcareer: UIButton!
    @IBOutlet weak var tapbody: UIButton!
    @IBOutlet weak var taphappiness: UIButton!

    @IBAction func tapHappiness(_ sender: Any) {
        
        happinesstapped()
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
        
        ref?.child("Users").child(uid).child(selectedcategory).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if var activityvalue = value?["Targets1"] as? String {
                
                
            }
            
            
            if var activityvalue = value?["Targets2"] as? String {
                                
                
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
