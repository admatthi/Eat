//
//  HomeViewController.swift
//  Eat
//
//  Created by Alek Matthiessen on 5/20/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import FBSDKCoreKit

var thisyear = String()

class HomeViewController: UIViewController {

    @IBOutlet weak var healthynumber: UILabel!
    
    @IBOutlet weak var totalnumber: UILabel!
    @IBOutlet weak var healthypercent: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        //        background.layer.borderColor =
        //        background.layer.borderWidth = 1.0
        
        let calendar = Calendar.current
        var weekOfYear = calendar.component(.weekOfYear, from: Date.init(timeIntervalSinceNow: 0))
        var monthOfYear = calendar.component(.month, from: Date.init(timeIntervalSinceNow: 0))
        
        
        thisweek = String(weekOfYear)
        thismonth = String(monthOfYear)
        thisyear = "2018"
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM//dd//yyyy"
        thisday = formatter.string(from: date)
        
        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in
            
            DispatchQueue.main.async {
                
                self.performSegue(withIdentifier: "HomeToIntroduction", sender: self)
                
            }
            
        } else {
            
            uid = (Auth.auth().currentUser?.uid)!
            
            // Do any additional setup after loading the view.
            
            let date = Date()
            let calendar = Calendar.current
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yy"
            todaysdate =  dateFormatter.string(from: date)
            
            uid = (Auth.auth().currentUser?.uid)!
            
            seeifthisisanewweek { () -> () in
                
                self.findlastloggeddata()
                
            }
            // Do any additional setup after loading the view.
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updatelabels() {
        
        
        var unhealthymeals = "0"
        self.healthynumber.text = "0"
        self.totalnumber.text = "0"
        
        if totalmealtoday != "" && totalmealtoday != "0" {
            
            self.totalnumber.text = totalmealtoday
            
            if totahealthymealtoday != "" && totahealthymealtoday != "0" {
                
                
                unhealthymeals = String(Int(totalmealtoday)! - Int(totahealthymealtoday)!)
                self.totalnumber.text = unhealthymeals
                self.healthynumber.text = totahealthymealtoday

                if unhealthymeals == "0" && Int(totahealthymealtoday)! >= 10  {
                    
                    healthypercent.text = "1"
                    
                } else {
                    
                    if Int(unhealthymeals)! < 1 && Int(totahealthymealtoday)! >= 20  {
                        
                        healthypercent.text = "2"
                        
                    }  else {
                        
                        if Int(unhealthymeals)! == 1 && Int(totahealthymealtoday)! >= 20  {
                            
                            healthypercent.text = "1"
                            
                        } else {
                            
                            healthypercent.text = "0"
                            
                            }
                        }
                    
                    }
                
                }
            }
        }
        
        //        if totalmealtoday != "0" && totahealthymealtoday != "0" && totahealthymealtoday != "" && totalmealtoday != "" {
        //
        //            var currencyDouble: Float = Float(totalmealtoday)!
        //            var totalSpending: Float = Float(totahealthymealtoday)!
        //
        //            let perCent = 100*(totalSpending/currencyDouble)
        //
        //            var perCentCGFloat =  CGFloat(perCent)
        //
        //            healthypercent.text = String(Int(perCentCGFloat))
        //
        //        } else {
        //
        //            healthypercent.text = "0"
        //        }
        

    
    func seeifthisisanewweek(completed: @escaping (() -> ()) ) {
        
        
        var functioncounter = 0
        ref?.child("OurUsers").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if var activityvalueee = value?["LastLoggedDay"] as? String {
                
                if thisday != activityvalueee {
                    
                    totalmealtoday = "0"
                    totahealthymealtoday = "0"
                    
                                        self.updatelabels()
                    
                } else {
                    
                    completed()
                    
                }
            } else {
                
                totalmealtoday = "0"
                totahealthymealtoday = "0"
                
                                self.updatelabels()
            }
            
            if var activityvalueee = value?["LastLoggedWeek"] as? String {
                
                if thisweek != activityvalueee {
                    
                    weekmeals = "0"
                    weekhealthymeals = "0"
                    
                } else {
                    
                    completed()
                    
                }
            } else {
                
                weekmeals = "0"
                weekhealthymeals = "0"
            }
            
            if var activityvalueee = value?["LastLoggedMonth"] as? String {
                
                if thismonth != activityvalueee {
                    
                    monthmeals = "0"
                    monthhealthymeals = "0"
                    
                } else {
                    
                    completed()
                    
                }
            } else {
                
                monthmeals = "0"
                monthhealthymeals = "0"
            }
            
            if var activityvalueee = value?["LastLoggedYear"] as? String {
                
                if thisyear != activityvalueee {
                    
                    totalmealsyear = "0"
                    totalhealthymeals = "0"
                    
                } else {
                    
                    completed()
                    
                }
            } else {
                
                totalmealsyear = "0"
                totalhealthymeals = "0"
            }
        })
        
    }
    
    func findlastloggeddata() {
        
        ref?.child("OurUsers").child(uid).child(thisday).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if var activityvalue = value?["TotalDayMeals"] as? String {
                
                totalmealtoday = activityvalue
                                self.updatelabels()
            }
            
            if var activityvaluee = value?["TotalHealthyDayMeals"] as? String {
                
                totahealthymealtoday = activityvaluee
                                self.updatelabels()
            }
            
        })
        
        
        ref?.child("OurUsers").child(uid).child(thisweek).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if var activityvalue = value?["TotalWeekMeals"] as? String {
                
                weekmeals = activityvalue
                
            }
            
            if var activityvaluee = value?["TotalHealthyWeekMeals"] as? String {
                
                weekhealthymeals = activityvaluee
                
            }
            
        })
        
        ref?.child("OurUsers").child(uid).child(thisyear).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if var activityvalue = value?["TotalYearMeals"] as? String {
                
                totalmealsyear = activityvalue
                
            }
            
            if var activityvaluee = value?["TotalHealthyYearMeals"] as? String {
                
                totalhealthymeals = activityvaluee
                
            }
            
        })
        
        ref?.child("OurUsers").child(uid).child(thismonth).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if var activityvalue = value?["TotalMonthMeals"] as? String {
                
                monthmeals = activityvalue
                
            }
            
            if var activityvaluee = value?["TotalHealthyMonthMeals"] as? String {
                
                monthhealthymeals = activityvaluee
                
            }
            
        })
        
        
        updatelabels()

    }
    
    func calculatenewmealvalues() {
        
        var newweek = Int(weekmeals)! + 1
        var newmonth = Int(monthmeals)! + 1
        var newyear = Int(totalmealsyear)! + 1
        var newday = Int(totalmealtoday)! + 1
        
        weekmeals = String(newweek)
        monthmeals = String(newmonth)
        totalmealsyear = String(newyear)
        totalmealtoday = String(newday)
        
        if mealhealth == "4" || mealhealth == "3" {
            
            var newhealthweek = Int(weekhealthymeals)! + 1
            var newhealthmonth = Int(monthhealthymeals)! + 1
            var newhealthyear = Int(totalhealthymeals)! + 1
            var newhealthyday = Int(totahealthymealtoday)! + 1
            
            ref?.child("OurUsers").child(uid).child(thisweek).updateChildValues(["TotalWeekMeals" : String(newweek), "TotalHealthyWeekMeals" : String(newhealthweek)])
            
            ref?.child("OurUsers").child(uid).child(thismonth).updateChildValues(["TotalMonthMeals" : String(newmonth), "TotalHealthyMonthMeals" : String(newhealthmonth)])
            
            ref?.child("OurUsers").child(uid).child(thisyear).updateChildValues(["TotalYearMeals" : String(newyear), "TotalHealthyYearMeals" : String(newhealthyear)])
            
            ref?.child("OurUsers").child(uid).child(thisday).updateChildValues(["TotalDayMeals" : String(newday), "TotalHealthyDayMeals" : String(newhealthyday)])
            
            
            ref?.child("OurUsers").child(uid).updateChildValues(["LastLoggedWeek" : thisweek, "LastLoggedMonth" : thismonth, "LastLoggedYear" : thisyear, "LastLoggedDay" : thisday])
            
            weekhealthymeals = String(newhealthweek)
            
            monthhealthymeals = String(newhealthmonth)
            
            totalhealthymeals = String(newhealthyear)
            
            totahealthymealtoday = String(newhealthyday)
            
            updatelabels()
        } else {
            
            var newhealthweek = weekhealthymeals
            
            var newhealthmonth = monthhealthymeals
            
            var newhealthyear = totalhealthymeals
            
            var newhealthyday = totahealthymealtoday
            
            
            ref?.child("OurUsers").child(uid).child(thisweek).updateChildValues(["TotalWeekMeals" : String(newweek), "TotalHealthyWeekMeals" : String(newhealthweek)])
            
            ref?.child("OurUsers").child(uid).child(thismonth).updateChildValues(["TotalMonthMeals" : String(newmonth), "TotalHealthyMonthMeals" : String(newhealthmonth)])
            
            ref?.child("OurUsers").child(uid).child(thisyear).updateChildValues(["TotalYearMeals" : String(newyear), "TotalHealthyYearMeals" : String(newhealthyear)])
            
            ref?.child("OurUsers").child(uid).child(thisday).updateChildValues(["TotalDayMeals" : String(newday), "TotalHealthyDayMeals" : String(newhealthyday)])
            
            
            ref?.child("OurUsers").child(uid).updateChildValues(["LastLoggedWeek" : thisweek, "LastLoggedMonth" : thismonth, "LastLoggedYear" : thisyear, "LastLoggedDay" : thisday])
            
            weekhealthymeals = String(newhealthweek)
            
            monthhealthymeals = String(newhealthmonth)
            
            totalhealthymeals = String(newhealthyear)
            
            totahealthymealtoday = String(newhealthyday)
            
            updatelabels()
        }
        
        
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

