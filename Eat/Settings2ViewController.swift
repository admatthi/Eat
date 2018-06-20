//
//  Settings2ViewController.swift
//  Eat
//
//  Created by Alek Matthiessen on 6/19/18.
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

class Settings2ViewController: UIViewController {

    @IBAction func tapLogout(_ sender: Any) {
        
        try! Auth.auth().signOut()

        self.performSegue(withIdentifier: "SettingsToLogin", sender: self)
    }
    @IBAction func tapTerms(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
