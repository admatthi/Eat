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


    @IBAction func tapCategory(_ sender: Any) {
        
        pickerView.alpha = 1
    }
    
    @IBAction func tapAdd(_ sender: Any) {
        
        if tf.text != "" {
    ref?.child("Users").child(uid).updateChildValues(["LastOpened" : todaysdate])

    ref?.child("Users").child(uid).child(selectedcategory).child(todaysdate).childByAutoId().updateChildValues(["Activity" : tf.text!, "Completed" : "False", "Tag" : ""])
            
            self.performSegue(withIdentifier: "NewTaskToHome", sender: self)
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
        categories.append("Body")
        categories.append("People")
        categories.append("Career")
        
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
        
        if categories.count > 0 {
            
            return categories[row]
            
        } else {
            
            return "0"
            
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if categories.count > 0 {
            
            return categories.count
            
        } else {
            
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        tapcategory.setTitle(categories[row], for: .normal)
        pickerView.alpha = 0 
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
