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
        
        nextcount()
        
    }
    @IBOutlet weak var tableView: UITableView!
    var ref: DatabaseReference?
    var category = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        whitelabel.layer.cornerRadius = 10.0
        whitelabel.layer.masksToBounds = true
        
        FBSDKAppEvents.logEvent("Read Book Viewed")
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
    

    
    var counter = 0
    
    func lastcount() {
        
        if counter == 0 {
            
            
        } else {
            
            counter -= 1
            showproperquote()
            
        }
        
        
    }
    
    func nextcount() {
        
        if counter > (quote.count-1) {
            
            self.performSegue(withIdentifier: "ReaderToOverview", sender: self)

            
        } else {

            showproperquote()

            counter += 1
            
        }

    }
    @IBOutlet weak var whitelabel: UILabel!
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
    

    @IBOutlet weak var two: UIImageView!
    @IBOutlet weak var one: UIImageView!
    @IBOutlet weak var three: UIImageView!
    @IBOutlet weak var four: UIImageView!
    @IBOutlet weak var five: UIImageView!
    @IBOutlet weak var six: UIImageView!
    @IBOutlet weak var seven: UIImageView!
    @IBOutlet weak var eight: UIImageView!
    @IBOutlet weak var nine: UIImageView!
    @IBOutlet weak var ten: UIImageView!
    @IBOutlet weak var eleven: UIImageView!
    @IBOutlet weak var twelve: UIImageView!
    @IBOutlet weak var thirteen: UIImageView!
    @IBOutlet weak var fourteen: UIImageView!
    @IBOutlet weak var fifteen: UIImageView!


    func showproperquote() {
        
        quotetext.text = quote[counter]
        
        if counter == 0 {
            
            one.alpha = 1
            two.alpha = 0.5
            three.alpha = 0.5
            four.alpha = 0.5
            five.alpha = 0.5
            six.alpha = 0.5
            seven.alpha = 0.5
            eight.alpha = 0.5
            nine.alpha = 0.5
            ten.alpha = 0.5
            eleven.alpha = 0.5
            twelve.alpha = 0.5
            thirteen.alpha = 0.5
            fourteen.alpha = 0.5
            fifteen.alpha = 0.5
            
        }
        
        if counter == 1 {
            
            two.alpha = 1
            one.alpha = 0.5
            three.alpha = 0.5
            four.alpha = 0.5
            five.alpha = 0.5
            six.alpha = 0.5
            seven.alpha = 0.5
            eight.alpha = 0.5
            nine.alpha = 0.5
            ten.alpha = 0.5
            eleven.alpha = 0.5
            twelve.alpha = 0.5
            thirteen.alpha = 0.5
            fourteen.alpha = 0.5
            fifteen.alpha = 0.5
            
        }
        
        if counter == 2 {
            
            three.alpha = 1
            two.alpha = 0.5
            one.alpha = 0.5
            four.alpha = 0.5
            five.alpha = 0.5
            six.alpha = 0.5
            seven.alpha = 0.5
            eight.alpha = 0.5
            nine.alpha = 0.5
            ten.alpha = 0.5
            eleven.alpha = 0.5
            twelve.alpha = 0.5
            thirteen.alpha = 0.5
            fourteen.alpha = 0.5
            fifteen.alpha = 0.5
            
        }
        
        if counter == 3 {
            
            four.alpha = 1
            two.alpha = 0.5
            three.alpha = 0.5
            one.alpha = 0.5
            five.alpha = 0.5
            six.alpha = 0.5
            seven.alpha = 0.5
            eight.alpha = 0.5
            nine.alpha = 0.5
            ten.alpha = 0.5
            eleven.alpha = 0.5
            twelve.alpha = 0.5
            thirteen.alpha = 0.5
            fourteen.alpha = 0.5
            fifteen.alpha = 0.5
            
        }
        
        if counter == 4 {
            
            five.alpha = 1
            two.alpha = 0.5
            three.alpha = 0.5
            four.alpha = 0.5
            one.alpha = 0.5
            six.alpha = 0.5
            seven.alpha = 0.5
            eight.alpha = 0.5
            nine.alpha = 0.5
            ten.alpha = 0.5
            eleven.alpha = 0.5
            twelve.alpha = 0.5
            thirteen.alpha = 0.5
            fourteen.alpha = 0.5
            fifteen.alpha = 0.5
            
        }
        
        if counter == 5 {
            
            six.alpha = 1
            two.alpha = 0.5
            three.alpha = 0.5
            four.alpha = 0.5
            five.alpha = 0.5
            one.alpha = 0.5
            seven.alpha = 0.5
            eight.alpha = 0.5
            nine.alpha = 0.5
            ten.alpha = 0.5
            eleven.alpha = 0.5
            twelve.alpha = 0.5
            thirteen.alpha = 0.5
            fourteen.alpha = 0.5
            fifteen.alpha = 0.5
            
        }
        
        if counter == 6 {
            
            seven.alpha = 1
            two.alpha = 0.5
            three.alpha = 0.5
            four.alpha = 0.5
            five.alpha = 0.5
            six.alpha = 0.5
            one.alpha = 0.5
            eight.alpha = 0.5
            nine.alpha = 0.5
            ten.alpha = 0.5
            eleven.alpha = 0.5
            twelve.alpha = 0.5
            thirteen.alpha = 0.5
            fourteen.alpha = 0.5
            fifteen.alpha = 0.5
            
        }
        
        if counter == 7 {
            
            eight.alpha = 1
            two.alpha = 0.5
            three.alpha = 0.5
            four.alpha = 0.5
            five.alpha = 0.5
            six.alpha = 0.5
            seven.alpha = 0.5
            one.alpha = 0.5
            nine.alpha = 0.5
            ten.alpha = 0.5
            eleven.alpha = 0.5
            twelve.alpha = 0.5
            thirteen.alpha = 0.5
            fourteen.alpha = 0.5
            fifteen.alpha = 0.5
            
        }
        
        if counter == 8 {
            
            nine.alpha = 1
            two.alpha = 0.5
            three.alpha = 0.5
            four.alpha = 0.5
            five.alpha = 0.5
            six.alpha = 0.5
            seven.alpha = 0.5
            eight.alpha = 0.5
            one.alpha = 0.5
            ten.alpha = 0.5
            eleven.alpha = 0.5
            twelve.alpha = 0.5
            thirteen.alpha = 0.5
            fourteen.alpha = 0.5
            fifteen.alpha = 0.5
            
        }
        
        if counter == 9 {
            
            ten.alpha = 1
            two.alpha = 0.5
            three.alpha = 0.5
            four.alpha = 0.5
            five.alpha = 0.5
            six.alpha = 0.5
            seven.alpha = 0.5
            eight.alpha = 0.5
            nine.alpha = 0.5
            one.alpha = 0.5
            eleven.alpha = 0.5
            twelve.alpha = 0.5
            thirteen.alpha = 0.5
            fourteen.alpha = 0.5
            fifteen.alpha = 0.5
            
        }
        
        if counter == 10 {
            
            eleven.alpha = 1
            two.alpha = 0.5
            three.alpha = 0.5
            four.alpha = 0.5
            five.alpha = 0.5
            six.alpha = 0.5
            seven.alpha = 0.5
            eight.alpha = 0.5
            nine.alpha = 0.5
            ten.alpha = 0.5
            one.alpha = 0.5
            twelve.alpha = 0.5
            thirteen.alpha = 0.5
            fourteen.alpha = 0.5
            fifteen.alpha = 0.5
            
        }
        
        if counter == 11 {
            
            twelve.alpha = 1
            two.alpha = 0.5
            three.alpha = 0.5
            four.alpha = 0.5
            five.alpha = 0.5
            six.alpha = 0.5
            seven.alpha = 0.5
            eight.alpha = 0.5
            nine.alpha = 0.5
            ten.alpha = 0.5
            eleven.alpha = 0.5
            one.alpha = 0.5
            thirteen.alpha = 0.5
            fourteen.alpha = 0.5
            fifteen.alpha = 0.5
            
        }
        
        if counter == 12 {
            
            thirteen.alpha = 1
            two.alpha = 0.5
            three.alpha = 0.5
            four.alpha = 0.5
            five.alpha = 0.5
            six.alpha = 0.5
            seven.alpha = 0.5
            eight.alpha = 0.5
            nine.alpha = 0.5
            ten.alpha = 0.5
            eleven.alpha = 0.5
            twelve.alpha = 0.5
            one.alpha = 0.5
            fourteen.alpha = 0.5
            fifteen.alpha = 0.5
            
        }
        
        if counter == 13 {
            
            fourteen.alpha = 1
            two.alpha = 0.5
            three.alpha = 0.5
            four.alpha = 0.5
            five.alpha = 0.5
            six.alpha = 0.5
            seven.alpha = 0.5
            eight.alpha = 0.5
            nine.alpha = 0.5
            ten.alpha = 0.5
            eleven.alpha = 0.5
            twelve.alpha = 0.5
            thirteen.alpha = 0.5
            one.alpha = 0.5
            fifteen.alpha = 0.5
            
        }
        
        if counter == 14 {
            
            fifteen.alpha = 1
            two.alpha = 0.5
            three.alpha = 0.5
            four.alpha = 0.5
            five.alpha = 0.5
            six.alpha = 0.5
            seven.alpha = 0.5
            eight.alpha = 0.5
            nine.alpha = 0.5
            ten.alpha = 0.5
            eleven.alpha = 0.5
            twelve.alpha = 0.5
            thirteen.alpha = 0.5
            fourteen.alpha = 0.5
            one.alpha = 0.5
            
        }
        //        backgroundlabel.backgroundColor = colors[counter]
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
