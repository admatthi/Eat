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
import AudioToolbox

var organizedids = [String]()

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
        
            self.goallabel.text = bodymonthlygoal
            
            self.queryforworkoutids { () -> () in
                
                self.queryforworkoutinfo()
                
            }
    }
    
    func careertapped() {
        
        tapcareer.alpha = 1
        tapbody.alpha = 0.5
        tappeople.alpha = 0.5
        taphappiness.alpha = 0.5
        
        selectedcategory = "Wealth"
        
            self.goallabel.text = careermonthlygoal
            
            self.queryforworkoutids { () -> () in
                
                self.queryforworkoutinfo()
                
            }
    }
    
    func peopletapped() {
        
        tappeople.alpha = 1
        tapbody.alpha = 0.5
        tapcareer.alpha = 0.5
        taphappiness.alpha = 0.5
        
        selectedcategory = "Love"
        
            self.goallabel.text = peoplemonthlygoal
            
            self.queryforworkoutids { () -> () in
                
                self.queryforworkoutinfo()
                
            }
    }
    
    func happinesstapped() {
        
        tappeople.alpha = 0.5
        tapbody.alpha = 0.5
        tapcareer.alpha = 0.5
        taphappiness.alpha = 1
        
        selectedcategory = "Happiness"
        
        
            self.goallabel.text = happinessmonthlygoal
            
            self.queryforworkoutids { () -> () in
                
                self.queryforworkoutinfo()
                
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
                
                self.performSegue(withIdentifier: "HomeToLogin5", sender: self)
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
            
            goallabel.text = "No Monthly Goal Set"
            
            queryforlastopened  { () -> () in
                
                self.bodytapped()

            }
            
            
        }
        //
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBOutlet weak var daysremainlabel: UILabel!
    var startdate = String()
    var firstmonthdate = String()
    
    func queryforlastopened(completed: @escaping (() -> ()) ) {
        
        ref?.child("Users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if var activityvalue = value?["FirstMonth"] as? String {
                
//
                self.firstmonthdate = activityvalue


                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM-dd-yy"
//                    let date1 = dateFormatter.date(from: self.startdate)!
                    let date1 = Date()
//                    let date1 = dateFormatter.date(from: thistoday)!
                    let date2 = dateFormatter.date(from: self.firstmonthdate)!

                    let difference = date2.days(from: date1)
                    print(difference)
                
                    self.daysremainlabel.text = "\(difference) DAYS REMAIN"
                    
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
    
    
    var yesterdaydate = String()
    
    var thedate = String()
    
     func queryforworkoutids(completed: @escaping (() -> ()) ) {
        
        var functioncounter = 0
       
        activityids.removeAll()
        activitylabels.removeAll()
        organizedids.removeAll()
        tags.removeAll()
        tableView.reloadData()
        ref?.child("Users").child(uid).child(selectedcategory).observeSingleEvent(of: .value, with: { (snapshot) in
            
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
    @IBOutlet weak var tableView: UITableView!
    func queryforworkoutinfo() {
        
        var functioncounter = 0
        var lowtohigh = 0
        var hightolow = activityids.count
        organizedids.removeAll()
        organizedids = activityids
        
        for each in activityids  {
            
        ref?.child("Users").child(uid).child(selectedcategory).child(each).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if var activityvalue = value?["Activity"] as? String {
                
                activitylabels[each] = activityvalue
                
            }
                
                
            if var activityvalue2 = value?["Tag"] as? String {
                    
                    tags[each] = activityvalue2
                
                if activityvalue2 == "Effective" {
                    
                    organizedids.insert(each, at: lowtohigh)
                    lowtohigh += 1
                    print(lowtohigh)
                } else {
                    
                    organizedids.insert(each, at: (hightolow))
                    hightolow -= 1
                    print(hightolow)
                }
                    
            }
            
                functioncounter += 1
                
                if functioncounter == activityids.count {
                    
                    self.tableView.reloadData()
                    
                }
        })
        
        }
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
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
        
        cell.selectionStyle = .none
        cell.seperator.alpha = 1
        cell.tagimage.alpha = 1
        
        if activitylabels.count > indexPath.row {
            
            cell.activitylabel.text = activitylabels[organizedids[indexPath.row]]
            
            cell.tagimage.image = UIImage(named: "\(tags[organizedids[indexPath.row]]!)")
            
            cell.tagimage.alpha = 1
            
        } else {
            
            cell.activitylabel.text = "You haven't addded any habits here yet."
            cell.seperator.alpha = 0
            cell.tagimage.alpha = 0
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        selectedtask  = activitylabels[organizedids[indexPath.row]]!
        selectedtaskid = organizedids[indexPath.row]
        
        selectedtag = tags[organizedids[indexPath.row]]!
        self.performSegue(withIdentifier: "HomeToEdit", sender: self)
        
//        let row = indexPath.row
//        let cellWhereIsTheLabel = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as! ActivitiesTableViewCell
//
//        cellWhereIsTheLabel.check.image = UIImage(named: "BlueCheck")
//
//        cellWhereIsTheLabel.activitylabel.alpha = 0.3

//    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))

    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new  controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the amount of nanoseconds from another date
    func nanoseconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.nanosecond], from: date, to: self).nanosecond ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        if nanoseconds(from: date) > 0 { return "\(nanoseconds(from: date))ns" }
        return ""
    }
}

