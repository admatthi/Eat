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

var bodymonthlygoal = String()
var careermonthlygoal = String()
var peoplemonthlygoal = String()

var selectedtask = String()
var selectedtaskid = String()

class WorkoutOptionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tappeople: UIButton!
    
    @IBOutlet weak var tapcareer: UIButton!
    @IBOutlet weak var tapbody: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
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
        
        selectedcategory = "Body"
        
        queryforlastopened  { () -> () in
            
            self.goallabel.text = bodymonthlygoal
            
            self.seeifnewday()
            
        }
    }
    
    func careertapped() {
        
        tapcareer.alpha = 1
        tapbody.alpha = 0.5
        tappeople.alpha = 0.5
        
        selectedcategory = "Career"
        
        queryforlastopened  { () -> () in
            
            self.goallabel.text = careermonthlygoal
            
            self.seeifnewday()
            
        }
    }
    
    func peopletapped() {
        
        tappeople.alpha = 1
        tapbody.alpha = 0.5
        tapcareer.alpha = 0.5
        
        selectedcategory = "People"
        
        queryforlastopened  { () -> () in
            
            self.goallabel.text = peoplemonthlygoal
            
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
            
            if var activityvalue3 = value?["CareerMonthlyGoal"] as? String {
                
                careermonthlygoal = activityvalue3
                
                completed()

            }

            
        })
    
    }
    
    func seeifnewday() {
        
        if lastopened == todaysdate {
            
            thedate = todaysdate
            
            queryforactivityids { () -> () in
            
                            self.queryforworkoutinfo()
                        }
        } else {
            

            let calendar = Calendar.current
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yy"
            yesterdaydate =  dateFormatter.string(from: Date().yesterday)
            
            self.tableView.reloadData()
//            thedate = yesterdaydate
//
//            queryforactivityids { () -> () in
//
//                self.queryforworkoutinfo()
//            }
            
        }
    }
    
    var yesterdaydate = String()
    
    var thedate = String()


    func queryforactivityids(completed: @escaping (() -> ()) ) {
        
        
        activityids.removeAll()
        activitylabels.removeAll()
        finished.removeAll()
        tags.removeAll()
        tableView.reloadData()
        
        var functioncounter = 0
        
        ref?.child("Users").child(uid).child(selectedcategory).child(thedate).observeSingleEvent(of: .value, with: { (snapshot) in
        
                    var value = snapshot.value as? NSDictionary
        
                    if let snapDict = snapshot.value as? [String:AnyObject] {
        
                        for each in snapDict {
        
                            let ids = each.key
        
                            activityids.append(ids)
        
                            functioncounter += 1
        
                            if functioncounter == snapDict.count {
        
                                completed()
        
                            }
        
        
                        }
        
                    }
        
                })
        
    }
    
    func queryforworkoutinfo() {
        
        var functioncounter = 0
        
        for each in activityids {
            
            ref?.child("Users").child(uid).child(selectedcategory).child(thedate).child(each).observeSingleEvent(of: .value, with: { (snapshot) in

                var value = snapshot.value as? NSDictionary
                
                if var activityvalue = value?["Activity"] as? String {
                    
                    activitylabels[each] = activityvalue
                    
                    
                }
                
                
                if var activityvalue = value?["Tag"] as? String {
                    
                    tags[each] = activityvalue
                    
                    
                }
                
                
                if var activityvalue = value?["Completed"] as? String {
                    
                    finished[each] = activityvalue
                    
                    
                }
                
                
                functioncounter += 1
                if functioncounter == activityids.count {
                    
                    self.tableView.reloadData()
                }
            })
            
            
        }
    }
    
    

    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if activitylabels.count > 0 {
            
            return activitylabels.count
            
        } else {
            
            return 1
        }
        
        
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Activities", for: indexPath) as! ActivitiesTableViewCell
        
        if activitylabels.count > indexPath.row {
            
            cell.activitylabel.text = activitylabels[activityids[indexPath.row]]
            
            if tags[activityids[indexPath.row]] == "Lesson Learned" {
                
                cell.tagg.image = UIImage(named: "Lesson Learned")
            }
            
            if tags[activityids[indexPath.row]] == "Win" {
                
                cell.tagg.image = UIImage(named: "Win")

            }
            
            if tags[activityids[indexPath.row]] == "Gratitude" {
                
                cell.tagg.image = UIImage(named: "Gratitude")

            }
            
            if finished[activityids[indexPath.row]] == "True" {
                
                cell.check.image = UIImage(named: "BlueCheck")
                
            } else {
                
                cell.check.image = UIImage(named: "GreyCheck")

            }


        } else {
            
            cell.activitylabel.text = "You haven't added any tasks for today today yet"

        }
        return cell
        
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedtask = activitylabels[activityids[indexPath.row]]!
        
        selectedtaskid = activityids[indexPath.row]
        
        self.performSegue(withIdentifier: "HomeToEditTask", sender: self)
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
