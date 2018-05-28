//
//  NewWeightViewController.swift
//  Eat
//
//  Created by Alek Matthiessen on 5/27/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

var currentweight = String()
var goalweight = String()
var updatedweight = String()

class NewWeightViewController: UIViewController {

    @IBOutlet weak var tf: UITextField!
    @IBAction func tapUPdate(_ sender: Any) {
        
        if tf.text != "" {
            
            
            updatedweight = tf.text!
            
    ref?.child("OurUsers").child(uid).updateChildValues(["Updated Weight" : updatedweight])
            
        self.performSegue(withIdentifier: "NotMyFriend", sender: self)
            
        } else {
            
            
        }
    }
    @IBOutlet weak var tapUpdate: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

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
