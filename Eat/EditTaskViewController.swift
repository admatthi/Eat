//
//  EditTaskViewController.swift
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

var tags3 = [String]()
var actualtags = [String]()
var selectedtag = String()

class EditTaskViewController: UIViewController, UITextFieldDelegate   {

    @IBAction func tapDelete(_ sender: Any) {
        
        ref?.child("Users").child(uid).child(selectedcategory).child(selectedtaskid).removeValue()
        
        self.performSegue(withIdentifier: "EditToHome", sender: self)


    }

    var tagselected = Bool()
    @IBOutlet weak var taptag: UIButton!
    @IBAction func tapTag(_ sender: Any) {
        
        
        selectedtag = "Effective"
        taptag.alpha = 1
        tapEffective.alpha = 0.5
        
    }
    @IBAction func tapCategory(_ sender: Any) {
        tagselected = false
        
        selectedcategory = "Love"
        tapcategory.alpha = 1
        taphealth.alpha = 0.5
        tapwealth.alpha = 0.5
        taphappiness.alpha = 0.5
    }
    @IBOutlet weak var tapwealth: UIButton!
    @IBOutlet weak var taphappiness: UIButton!
    @IBOutlet weak var taphealth: UIButton!
    
    @IBAction func tapE(_ sender: Any) {
        
        selectedtag = "Ineffective"
        taptag.alpha = 0.5
        tapEffective.alpha = 1
        
    }
    @IBAction func tapHappiness(_ sender: Any) {
        
        selectedcategory = "Happiness"
        taphappiness.alpha = 1
        taphealth.alpha = 0.5
        tapwealth.alpha = 0.5
        tapcategory.alpha = 0.5
        
    }
    @IBAction func tapHealth(_ sender: Any) {
        
        selectedcategory = "Health"
        taphealth.alpha = 1
        taphappiness.alpha = 0.5
        tapwealth.alpha = 0.5
        tapcategory.alpha = 0.5
        
    }
    @IBAction func tapWealth(_ sender: Any) {
        
        selectedcategory = "Wealth"
        tapwealth.alpha = 1
        taphappiness.alpha = 0.5
        taphealth.alpha = 0.5
        tapcategory.alpha = 0.5
        
    }
    @IBOutlet weak var tapEffective: UIButton!
    @IBAction func tapAdd(_ sender: Any) {
        
        if tf.text != "" {
            
        ref?.child("Users").child(uid).child(selectedcategory).child(selectedtaskid).updateChildValues(["Activity" : tf.text!, "Tag" : selectedtag])
            
            self.performSegue(withIdentifier: "EditToHome", sender: self)
        }
        
        
    }
    @IBAction func tapX(_ sender: Any) {
        
        ref?.child("Users").child(uid).child(selectedcategory).child(selectedtaskid).updateChildValues(["Activity" : selectedtask, "Tag" : selectedtag])
        
        self.performSegue(withIdentifier: "EditToHome", sender: self)
    }
    
    @IBOutlet weak var tapcategory: UIButton!
    @IBOutlet weak var tf: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        tf.delegate = self
        
        tf.becomeFirstResponder()
        
        tf.text = selectedtask

        loadselections()
        
    ref?.child("Users").child(uid).child(selectedcategory).child(selectedtaskid).removeValue()

        // Do any additional setup after loading the view.
    }
    
    func loadselections() {
        
        if selectedtag == "Effective" {
            
            taptag.alpha = 1
            tapEffective.alpha = 0.5
            
        } else {
            
            taptag.alpha = 0.5
            tapEffective.alpha = 1
        }
        
        if selectedcategory == "Wealth" {
            
            tapwealth.alpha = 1
            taphappiness.alpha = 0.5
            taphealth.alpha = 0.5
            tapcategory.alpha = 0.5
        } else {
            
            if selectedcategory == "Health" {
                
                taphealth.alpha = 1
                taphappiness.alpha = 0.5
                tapwealth.alpha = 0.5
                tapcategory.alpha = 0.5
            } else {
                
                if selectedcategory == "Happiness" {
                    
                    taphappiness.alpha = 1
                    taphealth.alpha = 0.5
                    tapwealth.alpha = 0.5
                    tapcategory.alpha = 0.5
                } else {
                    
                    if selectedcategory == "Love" {
                        
                        tapcategory.alpha = 1
                        taphealth.alpha = 0.5
                        tapwealth.alpha = 0.5
                        taphappiness.alpha = 0.5
                    }
                }
                
            }
        }
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

