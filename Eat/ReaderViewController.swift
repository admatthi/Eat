//
//  ReaderViewController.swift
//  Eat
//
//  Created by Alek Matthiessen on 7/10/18.
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
import AudioToolbox

var quote = [String]()
var selectedtitle = String()
var thischaptertitle = String()
var selectedbookid = String()

let gred = UIColor(red:0.95, green:0.09, blue:0.35, alpha:1.0)

let bblue = UIColor(red:0.01, green:0.61, blue:0.87, alpha:1.0)
let yyellow = UIColor(red:1.00, green:0.73, blue:0.00, alpha:1.0)
let lblue = UIColor(red:0.00, green:0.78, blue:0.83, alpha:1.0)
let oorange = UIColor(red:1.00, green:0.40, blue:0.08, alpha:1.0)


var colors = [UIColor]()

class ReaderViewController: UIViewController {
    @IBOutlet weak var titlelabel: UILabel!
    @IBAction func tapPrevious(_ sender: Any) {
        
        
        if counter > 0 {
            
            lastcount()

        }
    }
    @IBAction func tapNext(_ sender: Any) {
        
        if counter < quote.count  {
            
            nextcount()

            
        } else {
            
            self.performSegue(withIdentifier: "ReaderToOverview", sender: self)
        }
    }
    @IBOutlet weak var tableView: UITableView!
    var ref: DatabaseReference?
    var category = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
//        wtf()
        
            whatthehell()

        counter = 0
                // Do any additional setup after loading the view.
        
        colors.append(bblue)
        colors.append(yyellow)
        colors.append(oorange)
        colors.append(gred)
        colors.append(lblue)
        colors.append(bblue)
        colors.append(yyellow)
        colors.append(oorange)
        colors.append(gred)
        colors.append(lblue)
        colors.append(bblue)
        colors.append(yyellow)
        colors.append(oorange)
        colors.append(gred)
        colors.append(lblue)
        colors.append(bblue)
        colors.append(yyellow)
        colors.append(oorange)
        colors.append(gred)
        colors.append(lblue)
    }
    
    @IBOutlet weak var counterbutton: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var quotetext: UILabel!
    
    @IBOutlet weak var backgroundlabel: UILabel!
    
    func showproperquote() {
        
        quotetext.text = quote[counter]
        counterbutton.setTitle(String(counter+1), for: .normal )
        
//        backgroundlabel.backgroundColor = colors[counter]
    }
    
    var counter = 0
    
    func lastcount() {
        
        counter -= 1
        showproperquote()
        
    }
    
    func nextcount() {
        
        counter += 1
        showproperquote()
        
    }
    func whatthehell() {
        
        quote.removeAll()
        
        ref?.child("AllBooks").child(selectedbookid).child("Summary").child("1").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            
            
            if var activityvalue2 = value?["1"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["2"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["3"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["4"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["5"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["6"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["7"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["8"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["9"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["10"] as? String {
                
                quote.append(activityvalue2)
            }
            
            if var activityvalue2 = value?["11"] as? String {
                
                quote.append(activityvalue2)
            }
            if var activityvalue2 = value?["12"] as? String {
                
                quote.append(activityvalue2)
            }
            
            self.showproperquote()
        })
        
        
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
