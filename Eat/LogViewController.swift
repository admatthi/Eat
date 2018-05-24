//
//  LogViewController.swift
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

var mealhealth = String()
var totalmealsyear = String()
var weekmeals = String()
var monthmeals = String()
var totalmealtoday = String()
var totahealthymealtoday = String()

var totalhealthymeals = String()
var weekhealthymeals = String()
var monthhealthymeals = String()

var thisweek = String()
var thismonth = String()
var thisday = String()

class LogViewController: UIViewController {
    @IBOutlet weak var healthynumber: UILabel!
    
    @IBOutlet weak var totalnumber: UILabel!
    @IBOutlet weak var healthypercent: UILabel!
    @IBOutlet weak var tapbutton1: UIButton!
    @IBOutlet weak var tapbutton2: UIButton!
    @IBOutlet weak var tapbutton3: UIButton!
    @IBOutlet weak var tapbutton4: UIButton!
    @IBAction func tapButton1(_ sender: Any) {
        
        mealhealth = "1"
        
        calculatenewmealvalues()
        
    }
    @IBAction func tapButton2(_ sender: Any) {
        
        
        mealhealth = "2"
        
        calculatenewmealvalues()
        
        
    }
    @IBAction func tapButton3(_ sender: Any) {
        
        
        mealhealth = "3"
        
        calculatenewmealvalues()
        
        
    }
    @IBAction func tapButton4(_ sender: Any) {
        
        
        mealhealth = "4"
        
        calculatenewmealvalues()
        
        
    }
    
    
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
                
                self.performSegue(withIdentifier: "HomeToInitial2", sender: self)
                
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

            
            if weekmeals == "" {
                
                weekmeals = "0"
            }
            
            if monthmeals == "" {
                
                monthmeals = "0"
            }
            if totalmealsyear == "" {
                
                totalmealsyear = "0"
            }
            if totalmealtoday == "" {
                
                totalmealtoday = "0"
            }
        
            
            if weekhealthymeals == "" {
                
                weekhealthymeals = "0"
            }
            if monthhealthymeals == "" {
                
                monthhealthymeals = "0"
            }
            if totalhealthymeals == "" {
                
                totalhealthymeals = "0"
            }
            if totahealthymealtoday == "" {
                
                totahealthymealtoday = "0"
            }
            // Do any additional setup after loading the view.
        }
        
    }
    
    //    func updatelabels() {
    //
    //
    //        var unhealthymeals = "0"
    //        self.healthynumber.text = totahealthymealtoday
    //        self.totalnumber.text = unhealthymeals
    
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
    
    //        if totalmealtoday != "0" && totahealthymealtoday != "0" && totahealthymealtoday != "" && totalmealtoday != "" {
    //
    //            unhealthymeals = String(Int(totalmealtoday)! - Int(totahealthymealtoday)!)
    //            self.totalnumber.text = unhealthymeals
    //
    //
    //            if unhealthymeals == "0" && Int(totahealthymealtoday)! >= 10  {
    //
    //                healthypercent.text = "1"
    //            } else {
    //
    //                if Int(unhealthymeals)! < 1 && Int(totahealthymealtoday)! >= 20  {
    //
    //                    healthypercent.text = "2"
    //
    //                }  else {
    //
    //                    if Int(unhealthymeals)! == 1 && Int(totahealthymealtoday)! >= 20  {
    //
    //                        healthypercent.text = "1"
    //
    //                    } else {
    //
    //                        healthypercent.text = "0"
    //
    //                    }
    //                }
    //
    //            }
    //
    //
    //
    //        } else {
    //
    //            healthypercent.text = "0"
    //        }
    //
    //
    //
    //
    //    }
    

    
 
    
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
            self.performSegue(withIdentifier: "BackToHome", sender: self)

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
            self.performSegue(withIdentifier: "BackToHome", sender: self)

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

