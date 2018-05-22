//
//  LoginViewController.swift
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

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBAction func tapContinue(_ sender: Any) {
        
        login()

    }

    @IBOutlet weak var passwordtf: UITextField!
    @IBOutlet weak var emailtf: UITextField!
    
    func login() {
        
        var email = "\(emailtf.text!)"
        var password = "\(passwordtf.text!)"
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if let error = error {
                
                self.signup()
                
            } else {
                
                uid = (Auth.auth().currentUser?.uid)!
                
                let date = Date()
                let calendar = Calendar.current
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM-dd-yy"
                var todaysdate =  dateFormatter.string(from: date)
                
                
                
                DispatchQueue.main.async {
                    
                    self.performSegue(withIdentifier: "LoginToHome", sender: self)
                    
                }
            }
            
        }
        
    }
    
    @IBOutlet weak var errorlabel: UILabel!
    func signup() {
        
        
        var email = "\(emailtf.text!)"
        var password = "\(passwordtf.text!)"
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if let error = error {
                
                self.errorlabel.alpha = 1
                self.errorlabel.text = error.localizedDescription
                
                return
                
            } else {
                
                uid = (Auth.auth().currentUser?.uid)!
                
                let date = Date()
                let calendar = Calendar.current
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM-dd-yy"
                var todaysdate =  dateFormatter.string(from: date)
                
                
                
                ref?.child("NewUsers").child(uid).child("Actions").child("Other").childByAutoId().updateChildValues(["Action" : "Exercise", "Frequency" : "0", "Average" : "0"])
                
                ref?.child("NewUsers").child(uid).child("Actions").child("Other").childByAutoId().updateChildValues(["Action" : "Use Instagram", "Frequency" : "0", "Average" : "0"])
                
                ref?.child("NewUsers").child(uid).child("Actions").child("Other").childByAutoId().updateChildValues(["Action" : "Write", "Frequency" : "0", "Average" : "0"])
                
                ref?.child("NewUsers").child(uid).child("Actions").child("People").childByAutoId().updateChildValues(["Action" : "Dad", "Frequency" : "0", "Average" : "0"])
                
                ref?.child("NewUsers").child(uid).child("Actions").child("Food").childByAutoId().updateChildValues(["Action" : "Vegetables", "Frequency" : "0", "Average" : "0"])
                
                
                
                DispatchQueue.main.async {
                    
                    self.performSegue(withIdentifier: "LoginToHome", sender: self)
                    
                }
            }
            
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        ref = Database.database().reference()
        
        emailtf.delegate = self
        passwordtf.delegate = self
        emailtf.becomeFirstResponder()
        
        errorlabel.alpha = 0
        
        FBSDKAppEvents.logEvent("LoginScreen")
        
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

