//
//  GoalViewController.swift
//  Eat
//
//  Created by Alek Matthiessen on 7/9/18.
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

class GoalViewController: UIViewController, UITextFieldDelegate {


    

    @IBAction func tapAdd(_ sender: Any) {
        
        if monthlytf.text != "" {
            

            if selectedcategory == "Health" {
                
                ref?.child("Users").child(uid).updateChildValues(["BodyMonthlyGoal" : monthlytf.text!])
                
                self.performSegue(withIdentifier: "GoalToHome", sender: self)

            } else {
                
                if selectedcategory == "Wealth" {
                    
                    ref?.child("Users").child(uid).updateChildValues(["CareerMonthlyGoal" : monthlytf.text!])
                    
                    self.performSegue(withIdentifier: "GoalToHome", sender: self)
                    
                } else {
                    
                    if selectedcategory == "Happiness" {
                        
                        ref?.child("Users").child(uid).updateChildValues(["HappinessMonthlyGoal" : monthlytf.text!])
                        
                        self.performSegue(withIdentifier: "GoalToHome", sender: self)
                        
                    } else {
                        
                        if selectedcategory == "Love" {
                            
                            ref?.child("Users").child(uid).updateChildValues(["PeopleMonthlyGoal" : monthlytf.text!])
                            
                            self.performSegue(withIdentifier: "GoalToHome", sender: self)
                        }
                    }
                }
            }
        }
        
    }

        @IBOutlet weak var monthlytf: UITextField!
    
    @IBOutlet weak var categorylabel: UILabel!
    @IBOutlet weak var startdate: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        monthlytf.delegate = self
        
        monthlytf.becomeFirstResponder()
        
        categorylabel.text = selectedcategory
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM//dd//yyyy"
        let dateresult = formatter.string(from: date)
        
        startdate.text = dateresult
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

