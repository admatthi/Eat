//
//  FoodsViewController.swift
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

var ref: DatabaseReference?
var uid = String()

var stringweek = String()
var todaysdate = String()

var youractions = [String:String]()
var youractionids = [String]()

var todaysfeeling = String()
var selected = Int()
var selectedactivity = String()

var date = Date()

var thisfrequency = String()
var frequencies = [String:String]()
var averages = [String:String]()

var selectedfrequency = String()
var selectedaverage = String()
var selectedid = String()

var category = String()

class FoodsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tapbutton4: UIButton!
    @IBOutlet weak var tapbutton3: UIButton!
    @IBOutlet weak var tapbutton2: UIButton!
    @IBOutlet weak var tapbutton1: UIButton!
    
    @IBAction func tapButton4(_ sender: Any) {
        
        category = "Breakfast"
        
        tapbutton1.alpha = 0.5
        tapbutton2.alpha = 0.5
        tapbutton3.alpha = 0.5
        tapbutton4.alpha = 1
        tapbutton1.setBackgroundImage(nil, for: .normal)
        tapbutton2.setBackgroundImage(nil, for: .normal)
        tapbutton3.setBackgroundImage(nil, for: .normal)
        tapbutton4.setBackgroundImage(UIImage(named: "DarkBar"), for: .normal)
        
        
        youractions.removeAll()
        youractionids.removeAll()
        averages.removeAll()
        frequencies.removeAll()
        
        queryforactionids { () -> () in
            
            self.queryforyouractions()
        }
        
        tableView.reloadData()
        
        FBSDKAppEvents.logEvent("Breakfast")
        
    }
    
    
    @IBAction func tapButton3(_ sender: Any) {
        
        tapbutton1.alpha = 0.5
        tapbutton2.alpha = 0.5
        tapbutton3.alpha = 1
        tapbutton4.alpha = 0.5
        tapbutton1.setBackgroundImage(nil, for: .normal)
        tapbutton2.setBackgroundImage(nil, for: .normal)
        tapbutton4.setBackgroundImage(nil, for: .normal)
        tapbutton3.setBackgroundImage(UIImage(named: "DarkBar"), for: .normal)
        
        category = "Lunch"
        
        youractions.removeAll()
        youractionids.removeAll()
        averages.removeAll()
        frequencies.removeAll()
        
        queryforactionids { () -> () in
            
            self.queryforyouractions()
        }
        
        tableView.reloadData()
        
        FBSDKAppEvents.logEvent("Lunch")
        
    }
    
    
    @IBAction func tapButton2(_ sender: Any) {
        
        tapbutton1.alpha = 0.5
        tapbutton4.alpha = 0.5
        tapbutton3.alpha = 0.5
        tapbutton2.alpha = 1
        tapbutton1.setBackgroundImage(nil, for: .normal)
        tapbutton4.setBackgroundImage(nil, for: .normal)
        tapbutton3.setBackgroundImage(nil, for: .normal)
        tapbutton2.setBackgroundImage(UIImage(named: "DarkBar"), for: .normal)
        
        category = "Dinner"
        
        youractions.removeAll()
        youractionids.removeAll()
        averages.removeAll()
        frequencies.removeAll()
        
        queryforactionids { () -> () in
            
            self.queryforyouractions()
        }
        
        tableView.reloadData()
        
        FBSDKAppEvents.logEvent("Dinner")
        
    }
    
    
    @IBAction func tapButton1(_ sender: Any) {
        
        tapbutton4.alpha = 0.5
        tapbutton2.alpha = 0.5
        tapbutton3.alpha = 0.5
        tapbutton1.alpha = 1
        tapbutton4.setBackgroundImage(nil, for: .normal)
        tapbutton2.setBackgroundImage(nil, for: .normal)
        tapbutton3.setBackgroundImage(nil, for: .normal)
        tapbutton1.setBackgroundImage(UIImage(named: "DarkBar"), for: .normal)
        
        category = "Snacks"
        
        youractions.removeAll()
        youractionids.removeAll()
        averages.removeAll()
        frequencies.removeAll()
        
        queryforactionids { () -> () in
            
            self.queryforyouractions()
        }
        
        tableView.reloadData()
        
        FBSDKAppEvents.logEvent("Snacks")
        
    }
    
    func queryforactionids(completed: @escaping (() -> ()) ) {
        
        var functioncounter = 0
        ref?.child(category).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for each in snapDict {
                    
                    let ids = each.key
                    
                    youractionids.append(ids)
                    
                    functioncounter += 1
                    
                    if functioncounter == snapDict.count {
                        
                        completed()
                        
                    }
                    
                    
                }
                
            }
            
        })
    }
    
    func queryforyouractions() {
        
        var functioncounter = 0
        
        for each in youractionids {
            ref?.child(category).child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                if var activityvalue = value?["Meal"] as? String {
                    
                    youractions[each] = activityvalue
                    
                    
                }
                
                functioncounter += 1
                if functioncounter == youractionids.count {
                    
                    self.tableView.reloadData()
                }
            })
            
            
        }
    }
    
    func queryfocompletedfoods() {
        
        //        ref?.child(uid).child(todaysdate).child(completedfoods).observeSingleEvent(of: .value, with: { (snapshot) in
        //
        //            var value = snapshot.value as? NSDictionary
        //
        //            if let snapDict = snapshot.value as? [String:AnyObject] {
        //
        //                for each in snapDict {
        //
        //                    let ids = each.key
        //
        //                    youractionids.append(ids)
        //
        //                    functioncounter += 1
        //
        //                    if functioncounter == snapDict.count {
        //
        //                        completed()
        //
        //                    }
        //
        //
        //                }
        //
        //            }
        //
        //        })
        
    }
    
    
    
    
    
    
    
    
    @IBOutlet weak var tapcancel: UIButton!
    @IBOutlet weak var happinesslabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        //        background.layer.borderColor =
        //        background.layer.borderWidth = 1.0
        
        let calendar = Calendar.current
        var weekOfYear = calendar.component(.weekOfYear, from: Date.init(timeIntervalSinceNow: 0))
        
        stringweek = String(weekOfYear)
        
        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in
            
            DispatchQueue.main.async {
                
                self.performSegue(withIdentifier: "NewToLogin", sender: self)
                
            }
            
        } else {
            
            uid = (Auth.auth().currentUser?.uid)!
            
            
            // Do any additional setup after loading the view.
            
            let date = Date()
            let calendar = Calendar.current
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yy"
            todaysdate =  dateFormatter.string(from: date)
            
            category = "Snacks"
            
            uid = (Auth.auth().currentUser?.uid)!
            youractions.removeAll()
            youractionids.removeAll()
            averages.removeAll()
            frequencies.removeAll()
            
            queryforactionids { () -> () in
                
                self.queryforyouractions()
            }
            
            selected = 10000
            
            FBSDKAppEvents.logEvent("HomeScreen")
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if youractions.count > 0 {
            
            //            hideloading()
            
            return youractions.count
            
        } else {
            
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Sup", for: indexPath) as! FoodsTableViewCell
        
        cell.selectionStyle = .none
        
        //        cell.food.layer.masksToBounds = false
        //        cell.food.layer.cornerRadius = cell.food.layer.frame.height/2
        //        cell.food.clipsToBounds = true
        
        if youractions.count > indexPath.row {
            
            
            cell.habir.text = youractions[youractionids[indexPath.row]]
            
            if averages.count > indexPath.row {
                
//                cell.averagelabel.text = averages[youractionids[indexPath.row]]!
                
                if averages[youractionids[indexPath.row]]! == "Complete" {
                    
                    //                    cell.average.image = UIImage(named: "DarkOutline")
                }
                if averages[youractionids[indexPath.row]]! == "NotComplete" {
                    
                    //                    cell.average.image = UIImage(named: "DarkOutline")
                }
                
//                cell.frequency.alpha = 0
                
            } else {
                
                //                cell.average.alpha = 1
//                cell.frequency.text = "eat until full"
                //                cell.average.image = UIImage(named: "DarkOutline")
                
            }
            
        } else {
            
//            cell.habir.text = "You haven't added anything here."
            
        }
        
        
        //        cell.average.image = UIImage(named: "DarkOutline")
        
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        selected = indexPath.row
        //
        //            selectedactivity = youractions[youractionids[indexPath.row]]!
        //            selectedid = youractionids[indexPath.row]
        
        if averages.count >= indexPath.row && frequencies.count >= indexPath.row {
            //
            //                selectedaverage = averages[youractionids[indexPath.row]]!
            //                selectedfrequency = frequencies[youractionids[indexPath.row]]!
            
            //                selectedaverage = "0"
            //                selectedfrequency = "0"
            
            //                self.performSegue(withIdentifier: "HomeToFeels", sender: self)
            
        } else {
            //
            //                selectedaverage = "0"
            //                selectedfrequency = "0"
            //                self.performSegue(withIdentifier: "HomeToFeels", sender: self)
            
        }
        
        FBSDKAppEvents.logEvent("LogEventTableView")
        
        
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
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



