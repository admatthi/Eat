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
class EditTaskViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {

    @IBAction func tapTag(_ sender: Any) {
        
        pickerView.alpha = 1

    }
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var taptag: UIButton!
    @IBOutlet weak var tasklabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasklabel.text = selectedtask
        
        ref = Database.database().reference()

        tags3.removeAll()
        tags3.append("Lesson Learned")
        tags3.append("Win")
        tags3.append("Grateful")
        
        pickerView.alpha = 0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if tags3.count > 0 {
            
            return tags3[row]
            
        } else {
            
            return "0"
            
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if tags3.count > 0 {
            
            return tags3.count
            
        } else {
            
            return 1
        }
    }
    
    @IBOutlet weak var tagimage: UIImageView!
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        tagimage.image = UIImage(named: "\(tags3[row])")
            ref?.child("Users").child(uid).child(selectedcategory).child(todaysdate).child(selectedtaskid).updateChildValues(["Tag" : "\(tags3[row])"])

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
