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
import UserNotifications

var thisyear = String()
var healthy1 = CGFloat()
var healthy2 = CGFloat()
var healthy3 = CGFloat()
var healthy4 = CGFloat()
var healthy5 = CGFloat()
var healthy6 = CGFloat()
var healthy7 = CGFloat()

var unhealthy1 = CGFloat()
var unhealthy2 = CGFloat()
var unhealthy3 = CGFloat()
var unhealthy4 = CGFloat()
var unhealthy5 = CGFloat()
var unhealthy6 = CGFloat()
var unhealthy7 = CGFloat()

var lightorange = UIColor(red:0.95, green:0.57, blue:0.73, alpha:1.0)

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let cellId = "cellId"
    
    var healthyvalues = [CGFloat]()
    var unhealthyvalues = [CGFloat]()
    
    @IBOutlet weak var healthynumber: UILabel!
    
    @IBOutlet weak var totalnumber: UILabel!
    @IBOutlet weak var healthypercent: UILabel!
    
    @IBOutlet weak var onebottom: UILabel!
    @IBOutlet weak var twobottom: UILabel!
    @IBOutlet weak var threebottom: UILabel!
    @IBOutlet weak var fourbottom: UILabel!
    @IBOutlet weak var fivebottom: UILabel!
    @IBOutlet weak var sixbottom: UILabel!
    @IBOutlet weak var sevenbottom: UILabel!
    
    @IBOutlet weak var uonebottom: UILabel!
    @IBOutlet weak var utwobottom: UILabel!
    @IBOutlet weak var uthreebottom: UILabel!
    @IBOutlet weak var ufourbottom: UILabel!
    @IBOutlet weak var ufivebottom: UILabel!
    @IBOutlet weak var usixbottom: UILabel!
    @IBOutlet weak var usevenbottom: UILabel!


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

//            uid = "7SZwrR5kFIgLMRbwdXeSraaedcv2"
            
            seeifthisisanewweek { () -> () in
                
                self.findlastloggeddata()
                
            }
            
            collectionView?.backgroundColor = .white
            
            collectionView?.register(BarCell.self, forCellWithReuseIdentifier: cellId)
            
            collectionVie2?.backgroundColor = .white
            
            collectionVie2?.register(BarCell.self, forCellWithReuseIdentifier: cellId)
            
            // Do any additional setup after loading the view.
        }
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
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
            
            if var activityvalue2 = value?["TotalDayMeals"] as? String {
                
                totalmealtoday = activityvalue2
                                self.updatelabels()
            }
            
            if var activityvaluee3 = value?["TotalHealthyDayMeals"] as? String {
                
                totahealthymealtoday = activityvaluee3
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
            
            
            if var one = value?["Healthy1"] as? String {
                
                healthy1 = CGFloat(Int(one)!)
                
            } else {
                
                healthy1 = 0

            }
            
            if var two = value?["Healthy2"] as? String {
                
                healthy2 = CGFloat(Int(two)!)
                
            } else {
                
                healthy2 = 0
            }
            
            if var three = value?["Healthy3"] as? String {
                
                healthy3 = CGFloat(Int(three)!)
                
            } else {
                
                healthy3 = 0
            }
            
            if var four = value?["Healthy4"] as? String {
                
                healthy4 = CGFloat(Int(four)!)
                
            }else {
                
                healthy4 = 0
            }
            
            if var five = value?["Healthy5"] as? String {
                
                healthy5 = CGFloat(Int(five)!)
                
            }else {
                
                healthy5 = 0
            }
            
            if var six = value?["Healthy6"] as? String {
                
                healthy6 = CGFloat(Int(six)!)
                
            }else {
                
                healthy6 = 0
            }
            
            if var seven = value?["Healthy7"] as? String {
                
                healthy7 = CGFloat(Int(seven)!)
                
                self.healthyvalues = [healthy1, healthy2, healthy3, healthy4, healthy5, healthy6, healthy7]
                self.onebottom.text = String(Int(self.healthyvalues[0]))
                self.twobottom.text = String(Int(self.healthyvalues[1]))
                self.threebottom.text = String(Int(self.healthyvalues[2]))
                self.fourbottom.text = String(Int(self.healthyvalues[3]))
                self.fivebottom.text = String(Int(self.healthyvalues[4]))
                self.sixbottom.text = String(Int(self.healthyvalues[5]))
                self.sevenbottom.text = String(Int(self.healthyvalues[6]))
                self.collectionView.reloadData()

            }else {
                
                healthy7 = 0
                
                self.healthyvalues = [healthy1, healthy2, healthy3, healthy4, healthy5, healthy6, healthy7]
                self.onebottom.text = String(Int(self.healthyvalues[0]))
                self.twobottom.text = String(Int(self.healthyvalues[1]))
                self.threebottom.text = String(Int(self.healthyvalues[2]))
                self.fourbottom.text = String(Int(self.healthyvalues[3]))
                self.fivebottom.text = String(Int(self.healthyvalues[4]))
                self.sixbottom.text = String(Int(self.healthyvalues[5]))
                self.sevenbottom.text = String(Int(self.healthyvalues[6]))
            
                self.collectionView.reloadData()

            }
            
            if var one = value?["unHealthy1"] as? String {
                
                unhealthy1 = CGFloat(Int(one)!)
                
            } else {
                
                unhealthy1 = 0
                
            }
            
            if var two = value?["unHealthy2"] as? String {
                
                unhealthy2 = CGFloat(Int(two)!)
                
            } else {
                
                unhealthy2 = 0
            }
            
            if var three = value?["unHealthy3"] as? String {
                
                unhealthy3 = CGFloat(Int(three)!)
                
            } else {
                
                unhealthy3 = 0
            }
            
            if var four = value?["unHealthy4"] as? String {
                
                unhealthy4 = CGFloat(Int(four)!)
                
            }else {
                
                unhealthy4 = 0
            }
            
            if var five = value?["unHealthy5"] as? String {
                
                unhealthy5 = CGFloat(Int(five)!)
                
            }else {
                
                unhealthy5 = 0
            }
            
            if var six = value?["unHealthy6"] as? String {
                
                unhealthy6 = CGFloat(Int(six)!)
                
            }else {
                
                unhealthy6 = 0
            }
            
            if var seven = value?["unHealthy7"] as? String {
                
                unhealthy7 = CGFloat(Int(seven)!)
                
                self.unhealthyvalues = [unhealthy1, unhealthy2, unhealthy3, unhealthy4, unhealthy5, unhealthy6, unhealthy7]
                self.uonebottom.text = String(Int(self.unhealthyvalues[0]))
                self.utwobottom.text = String(Int(self.unhealthyvalues[1]))
                self.uthreebottom.text = String(Int(self.unhealthyvalues[2]))
                self.ufourbottom.text = String(Int(self.unhealthyvalues[3]))
                self.ufivebottom.text = String(Int(self.unhealthyvalues[4]))
                self.usixbottom.text = String(Int(self.unhealthyvalues[5]))
                self.usevenbottom.text = String(Int(self.unhealthyvalues[6]))
                self.collectionVie2.reloadData()
                
            }else {
                
                unhealthy7 = 0
                
                self.unhealthyvalues = [unhealthy1, unhealthy2, unhealthy3, unhealthy4, unhealthy5, unhealthy6, unhealthy7]
                self.uonebottom.text = String(Int(self.unhealthyvalues[0]))
                self.utwobottom.text = String(Int(self.unhealthyvalues[1]))
                self.uthreebottom.text = String(Int(self.unhealthyvalues[2]))
                self.ufourbottom.text = String(Int(self.unhealthyvalues[3]))
                self.ufivebottom.text = String(Int(self.unhealthyvalues[4]))
                self.usixbottom.text = String(Int(self.unhealthyvalues[5]))
                self.usevenbottom.text = String(Int(self.healthyvalues[6]))
                
                self.collectionVie2.reloadData()
                
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
    @IBOutlet weak var collectionVie2: UICollectionView!
    
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if collectionView.tag == 1 {
            
            return healthyvalues.count
            
        } else {
            
            if collectionView.tag == 2 {
                
                return unhealthyvalues.count
                
            } else {
                
                return 0
            }
        }
        
        
    }
    
    func maxHeight() -> CGFloat {
        
        if collectionView.tag == 1 {
            
//            return healthyvalues.max()! + 50
            
            return 50
            
        } else {
            
            if collectionView.tag == 2 {
                
//                return unhealthyvalues.max()! + 50
                
                return 50

            } else {
                
                return 0
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BarCell
        
        if collectionView.tag == 1 {
        
        cell.barView.backgroundColor = lightgreen

        if let max = healthyvalues.max() {

        if max != 0 {
            
            let value = healthyvalues[indexPath.item]
//            let ratio = value / max
            let ratio = value / 5

            cell.barHeightConstraint?.constant = maxHeight() * ratio
            
        } else {
            
            cell.barHeightConstraint?.constant = 0
            
            }
            
        }
            
        } else {
            
            if collectionView.tag == 2 {
                
                if let max = unhealthyvalues.max() {
                    
                    cell.barView.backgroundColor = lightorange

                    if max != 0 {
                        
                        let value = unhealthyvalues[indexPath.item]
//                                    let ratio = value / max
                        let ratio = value / 5

                        cell.barHeightConstraint?.constant = maxHeight() * ratio
                        
                    } else {
                        
                        cell.barHeightConstraint?.constant = 0
                        
                        
                    }
                    
                }
                
            }
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 10, height: maxHeight())
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 75, left: 20, bottom: 30, right: 0)
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

