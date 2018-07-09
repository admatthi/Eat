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

class WorkoutViewController: UIViewController,UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    var tagselected = Bool()
    @IBOutlet weak var taptag: UIButton!
    @IBAction func tapTag(_ sender: Any) {
        
        tagselected = true
        pickerView.reloadAllComponents()
        pickerView.alpha = 1
    }
    @IBAction func tapCategory(_ sender: Any) {
        tagselected = false
        pickerView.reloadAllComponents()
        pickerView.alpha = 1
    }
    
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
        
        pickerView.alpha = 0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if tagselected {
            
            return actualtags[row]
            
        } else {
            
            if tagselected == false {
                
                return categories[row]
                
            } else {
                
                return "0"
                
            }
            
        }

        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        if tagselected {
            
            return actualtags.count
            
        } else {
            
            if tagselected == false {
                
                return categories.count
                
            } else {
                
                return 1
                
            }
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        if tagselected {
            
            selectedtag = actualtags[row]
            taptag.setTitle("", for: .normal)
            taptag.setBackgroundImage(UIImage(named: actualtags[row]), for: .normal)
            
        } else {
            
            if tagselected == false {
                
                selectedcategory = categories [row]
                tapcategory.setTitle(categories[row], for: .normal)

            } else {
                
            }
            
        }
        
        pickerView.alpha = 0 
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
