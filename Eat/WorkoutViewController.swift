//
//  WorkoutViewController.swift
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

var categories = [String]()

class WorkoutViewController: UIViewController,UITextFieldDelegate {

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
   
    ref?.child("Users").child(uid).updateChildValues(["LastOpened" : todaysdate])

    ref?.child("Users").child(uid).child(selectedcategory).childByAutoId().updateChildValues(["Activity" : tf.text!, "Tag" : selectedtag])
            
            self.performSegue(withIdentifier: "AddToHome", sender: self)
        }

        
    }
    
    @IBOutlet weak var pickerView: UIPickerView!

    @IBOutlet weak var tapcategory: UIButton!
    @IBOutlet weak var tf: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        tf.delegate = self
        
        tf.becomeFirstResponder()

        categories.removeAll()
        categories.append("Health")
        categories.append("Wealth")
        categories.append("Love")
        categories.append("Happiness")
        
        actualtags.removeAll()
        actualtags.append("Lesson Learned")
        actualtags.append("Win")
        actualtags.append("Grateful")
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
  
 
    

    
 
var selectedtag = String()
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
