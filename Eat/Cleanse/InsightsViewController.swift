//
//  InsightsViewController.swift
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

class InsightsViewController: UIViewController {

    @IBAction func tapUpdateWeight(_ sender: Any) {
        
    
    }
    @IBAction func tapLogout(_ sender: Any) {
        
        
    }
    @IBOutlet weak var totalhealthymealsytd2: UILabel!
    @IBOutlet weak var monthhealthymeal2: UILabel!
    @IBOutlet weak var weekhealthymeal2: UILabel!
    @IBOutlet weak var monthmeals2: UILabel!
    @IBOutlet weak var weekmeals2: UILabel!
    @IBOutlet weak var totalmealsytd2: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadlabels()
        // Do any additional setup after loading the view.
        
        FBSDKAppEvents.logEvent("Insights")
        
        ref?.child("OurUsers").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if var activityvalue2 = value?["Current Weight"] as? String {
                
                currentweight = activityvalue2
                
                self.loadlabels()
            }
            
            if var activityvaluee3 = value?["Goal Weight"] as? String {
                
                goalweight = activityvaluee3
                
                self.loadlabels()
            }
            
            if var activityvaluee4 = value?["Updated Weight"] as? String {
                
                updatedweight = activityvaluee4
                
                self.loadlabels()
            }
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var goallabel: UILabel!
    
    @IBOutlet weak var changelabel: UILabel!
    @IBOutlet weak var currentlabel: UILabel!
    @IBOutlet weak var lbslabel: UILabel!
    
    func loadlabels() {
        
        if goalweight != "" {
            
            goallabel.text = goalweight
            
        }
        
        if currentweight != "" {
            
            currentlabel.text = currentweight
        }
        
        if goalweight != "" && currentweight != "" && updatedweight != "" {
            
            changelabel.text = String(Int(currentweight)! - Int(updatedweight)!)
       
            if Int(currentweight)! > Int(updatedweight)! {
                
                lbslabel.text = "lbs lost"
                
            } else {
                
                lbslabel.text = "lbs gained"
            }
        } else {
            
            changelabel.text = "-"
        }
        
        
//        if totalmealsyear != "" {
//
//            totalmealsytd2.text = totalmealsyear
//
//        } else {
//
//            totalmealsytd2.text = "0"
//        }
//
//        if weekmeals != "" {
//
//            weekmeals2.text = weekmeals
//
//        } else {
//
//            weekmeals2.text = "0"
//        }
//
//        if monthmeals != "" {
//
//            monthmeals2.text = monthmeals
//
//        } else {
//
//            monthmeals2.text = "0"
//        }
//
//        if totalhealthymeals != "" {
//
//            totalhealthymealsytd2.text = totalhealthymeals
//
//        } else {
//
//            totalhealthymealsytd2.text = "0"
//        }
//
//        if weekhealthymeals != "" {
//
//            weekhealthymeal2.text = weekhealthymeals
//
//        } else {
//
//            weekhealthymeal2.text = "0"
//        }
//
//        if monthhealthymeals != "" {
//
//            monthhealthymeal2.text = monthhealthymeals
//
//        } else {
//
//            monthhealthymeal2.text = "0"
//        }
        
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
