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
    
    var bookmarktapped = Bool()
    
    func showbookmark() {
        
        if bookmarktapped {
            
            tapbookmark.setImage(UIImage(named: "LightBookMark"), for: .normal)
            
        } else {
            
            tapbookmark.setImage(UIImage(named: "DarkBookMark"), for: .normal)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        whitelabel.layer.cornerRadius = 10.0
        whitelabel.layer.masksToBounds = true
        
        bookmarktapped = true
        
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
        
        bookmarktapped = true
        tapbookmark.setImage(UIImage(named: "DarkBookMark"), for: .normal)    }
    
    @IBAction func tapBookMark(_ sender: Any) {
        
        if bookmarktapped {
            
            tapbookmark.setImage(UIImage(named: "LightBookMark"), for: .normal)
            
            bookmarktapped = false
            
            ref?.child("Users").child(uid).child("Favorites").childByAutoId().updateChildValues(["Text" : quote[counter]])
            
        } else {
            
            tapbookmark.setImage(UIImage(named: "DarkBookMark"), for: .normal)
            
            bookmarktapped = true
        }
        
    }
    @IBOutlet weak var tapbookmark: UIButton!
    func nextcount() {
        
        bookmarktapped = true
        tapbookmark.setImage(UIImage(named: "DarkBookMark"), for: .normal)

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
            
            one.image = UIImage(named: "OrangeCheck")
            two.image = UIImage(named: "OrangeCheck2")
            three.image = UIImage(named: "OrangeCheck2")
            four.image = UIImage(named: "OrangeCheck2")
            five.image = UIImage(named: "OrangeCheck2")
            six.image = UIImage(named: "OrangeCheck2")
            seven.image = UIImage(named: "OrangeCheck2")
            eight.image = UIImage(named: "OrangeCheck2")
            nine.image = UIImage(named: "OrangeCheck2")
            ten.image = UIImage(named: "OrangeCheck2")
            eleven.image = UIImage(named: "OrangeCheck2")
            twelve.image = UIImage(named: "OrangeCheck2")
            thirteen.image = UIImage(named: "OrangeCheck2")
            fourteen.image = UIImage(named: "OrangeCheck2")
            fifteen.image = UIImage(named: "OrangeCheck2")
            
        }
        
        if counter == 1 {
            
            one.image = UIImage(named: "OrangeCheck")
            two.image = UIImage(named: "OrangeCheck")
            three.image = UIImage(named: "OrangeCheck2")
            four.image = UIImage(named: "OrangeCheck2")
            five.image = UIImage(named: "OrangeCheck2")
            six.image = UIImage(named: "OrangeCheck2")
            seven.image = UIImage(named: "OrangeCheck2")
            eight.image = UIImage(named: "OrangeCheck2")
            nine.image = UIImage(named: "OrangeCheck2")
            ten.image = UIImage(named: "OrangeCheck2")
            eleven.image = UIImage(named: "OrangeCheck2")
            twelve.image = UIImage(named: "OrangeCheck2")
            thirteen.image = UIImage(named: "OrangeCheck2")
            fourteen.image = UIImage(named: "OrangeCheck2")
            fifteen.image = UIImage(named: "OrangeCheck2")
            
        }
        
        if counter == 2 {
            
            one.image = UIImage(named: "OrangeCheck")
            two.image = UIImage(named: "OrangeCheck")
            three.image = UIImage(named: "OrangeCheck")
            four.image = UIImage(named: "OrangeCheck2")
            five.image = UIImage(named: "OrangeCheck2")
            six.image = UIImage(named: "OrangeCheck2")
            seven.image = UIImage(named: "OrangeCheck2")
            eight.image = UIImage(named: "OrangeCheck2")
            nine.image = UIImage(named: "OrangeCheck2")
            ten.image = UIImage(named: "OrangeCheck2")
            eleven.image = UIImage(named: "OrangeCheck2")
            twelve.image = UIImage(named: "OrangeCheck2")
            thirteen.image = UIImage(named: "OrangeCheck2")
            fourteen.image = UIImage(named: "OrangeCheck2")
            fifteen.image = UIImage(named: "OrangeCheck2")
            
        }
        
        if counter == 3 {
            
            one.image = UIImage(named: "OrangeCheck")
            two.image = UIImage(named: "OrangeCheck")
            three.image = UIImage(named: "OrangeCheck")
            four.image = UIImage(named: "OrangeCheck")
            five.image = UIImage(named: "OrangeCheck2")
            six.image = UIImage(named: "OrangeCheck2")
            seven.image = UIImage(named: "OrangeCheck2")
            eight.image = UIImage(named: "OrangeCheck2")
            nine.image = UIImage(named: "OrangeCheck2")
            ten.image = UIImage(named: "OrangeCheck2")
            eleven.image = UIImage(named: "OrangeCheck2")
            twelve.image = UIImage(named: "OrangeCheck2")
            thirteen.image = UIImage(named: "OrangeCheck2")
            fourteen.image = UIImage(named: "OrangeCheck2")
            fifteen.image = UIImage(named: "OrangeCheck2")
            
        }
        
        if counter == 4 {
            
            one.image = UIImage(named: "OrangeCheck")
            two.image = UIImage(named: "OrangeCheck")
            three.image = UIImage(named: "OrangeCheck")
            four.image = UIImage(named: "OrangeCheck")
            five.image = UIImage(named: "OrangeCheck")
            six.image = UIImage(named: "OrangeCheck2")
            seven.image = UIImage(named: "OrangeCheck2")
            eight.image = UIImage(named: "OrangeCheck2")
            nine.image = UIImage(named: "OrangeCheck2")
            ten.image = UIImage(named: "OrangeCheck2")
            eleven.image = UIImage(named: "OrangeCheck2")
            twelve.image = UIImage(named: "OrangeCheck2")
            thirteen.image = UIImage(named: "OrangeCheck2")
            fourteen.image = UIImage(named: "OrangeCheck2")
            fifteen.image = UIImage(named: "OrangeCheck2")
            
        }
        
        if counter == 5 {
            
            one.image = UIImage(named: "OrangeCheck")
            two.image = UIImage(named: "OrangeCheck")
            three.image = UIImage(named: "OrangeCheck")
            four.image = UIImage(named: "OrangeCheck")
            five.image = UIImage(named: "OrangeCheck")
            six.image = UIImage(named: "OrangeCheck")
            seven.image = UIImage(named: "OrangeCheck2")
            eight.image = UIImage(named: "OrangeCheck2")
            nine.image = UIImage(named: "OrangeCheck2")
            ten.image = UIImage(named: "OrangeCheck2")
            eleven.image = UIImage(named: "OrangeCheck2")
            twelve.image = UIImage(named: "OrangeCheck2")
            thirteen.image = UIImage(named: "OrangeCheck2")
            fourteen.image = UIImage(named: "OrangeCheck2")
            fifteen.image = UIImage(named: "OrangeCheck2")
            
        }
        
        if counter == 6 {
            
            one.image = UIImage(named: "OrangeCheck")
            two.image = UIImage(named: "OrangeCheck")
            three.image = UIImage(named: "OrangeCheck")
            four.image = UIImage(named: "OrangeCheck")
            five.image = UIImage(named: "OrangeCheck")
            six.image = UIImage(named: "OrangeCheck")
            seven.image = UIImage(named: "OrangeCheck")
            eight.image = UIImage(named: "OrangeCheck2")
            nine.image = UIImage(named: "OrangeCheck2")
            ten.image = UIImage(named: "OrangeCheck2")
            eleven.image = UIImage(named: "OrangeCheck2")
            twelve.image = UIImage(named: "OrangeCheck2")
            thirteen.image = UIImage(named: "OrangeCheck2")
            fourteen.image = UIImage(named: "OrangeCheck2")
            fifteen.image = UIImage(named: "OrangeCheck2")
            
        }
        
        if counter == 7 {
            
            one.image = UIImage(named: "OrangeCheck")
            two.image = UIImage(named: "OrangeCheck")
            three.image = UIImage(named: "OrangeCheck")
            four.image = UIImage(named: "OrangeCheck")
            five.image = UIImage(named: "OrangeCheck")
            six.image = UIImage(named: "OrangeCheck")
            seven.image = UIImage(named: "OrangeCheck")
            eight.image = UIImage(named: "OrangeCheck")
            nine.image = UIImage(named: "OrangeCheck2")
            ten.image = UIImage(named: "OrangeCheck2")
            eleven.image = UIImage(named: "OrangeCheck2")
            twelve.image = UIImage(named: "OrangeCheck2")
            thirteen.image = UIImage(named: "OrangeCheck2")
            fourteen.image = UIImage(named: "OrangeCheck2")
            fifteen.image = UIImage(named: "OrangeCheck2")
        }
        
        if counter == 8 {
            
            one.image = UIImage(named: "OrangeCheck")
            two.image = UIImage(named: "OrangeCheck")
            three.image = UIImage(named: "OrangeCheck")
            four.image = UIImage(named: "OrangeCheck")
            five.image = UIImage(named: "OrangeCheck")
            six.image = UIImage(named: "OrangeCheck")
            seven.image = UIImage(named: "OrangeCheck")
            eight.image = UIImage(named: "OrangeCheck")
            nine.image = UIImage(named: "OrangeCheck")
            ten.image = UIImage(named: "OrangeCheck2")
            eleven.image = UIImage(named: "OrangeCheck2")
            twelve.image = UIImage(named: "OrangeCheck2")
            thirteen.image = UIImage(named: "OrangeCheck2")
            fourteen.image = UIImage(named: "OrangeCheck2")
            fifteen.image = UIImage(named: "OrangeCheck2")
            
        }
        
        if counter == 9 {
            
            one.image = UIImage(named: "OrangeCheck")
            two.image = UIImage(named: "OrangeCheck")
            three.image = UIImage(named: "OrangeCheck")
            four.image = UIImage(named: "OrangeCheck")
            five.image = UIImage(named: "OrangeCheck")
            six.image = UIImage(named: "OrangeCheck")
            seven.image = UIImage(named: "OrangeCheck")
            eight.image = UIImage(named: "OrangeCheck")
            nine.image = UIImage(named: "OrangeCheck")
            ten.image = UIImage(named: "OrangeCheck")
            eleven.image = UIImage(named: "OrangeCheck2")
            twelve.image = UIImage(named: "OrangeCheck2")
            thirteen.image = UIImage(named: "OrangeCheck2")
            fourteen.image = UIImage(named: "OrangeCheck2")
            fifteen.image = UIImage(named: "OrangeCheck2")
            
        }
        
        if counter == 10 {
            
            one.image = UIImage(named: "OrangeCheck")
            two.image = UIImage(named: "OrangeCheck")
            three.image = UIImage(named: "OrangeCheck")
            four.image = UIImage(named: "OrangeCheck")
            five.image = UIImage(named: "OrangeCheck")
            six.image = UIImage(named: "OrangeCheck")
            seven.image = UIImage(named: "OrangeCheck")
            eight.image = UIImage(named: "OrangeCheck")
            nine.image = UIImage(named: "OrangeCheck")
            ten.image = UIImage(named: "OrangeCheck")
            eleven.image = UIImage(named: "OrangeCheck")
            twelve.image = UIImage(named: "OrangeCheck2")
            thirteen.image = UIImage(named: "OrangeCheck2")
            fourteen.image = UIImage(named: "OrangeCheck2")
            fifteen.image = UIImage(named: "OrangeCheck2")
            
        }
        
        if counter == 11 {
            
            one.image = UIImage(named: "OrangeCheck")
            two.image = UIImage(named: "OrangeCheck")
            three.image = UIImage(named: "OrangeCheck")
            four.image = UIImage(named: "OrangeCheck")
            five.image = UIImage(named: "OrangeCheck")
            six.image = UIImage(named: "OrangeCheck")
            seven.image = UIImage(named: "OrangeCheck")
            eight.image = UIImage(named: "OrangeCheck")
            nine.image = UIImage(named: "OrangeCheck")
            ten.image = UIImage(named: "OrangeCheck")
            eleven.image = UIImage(named: "OrangeCheck")
            twelve.image = UIImage(named: "OrangeCheck")
            thirteen.image = UIImage(named: "OrangeCheck2")
            fourteen.image = UIImage(named: "OrangeCheck2")
            fifteen.image = UIImage(named: "OrangeCheck2")
            
        }
        
        if counter == 12 {
            
            one.image = UIImage(named: "OrangeCheck")
            two.image = UIImage(named: "OrangeCheck")
            three.image = UIImage(named: "OrangeCheck")
            four.image = UIImage(named: "OrangeCheck")
            five.image = UIImage(named: "OrangeCheck")
            six.image = UIImage(named: "OrangeCheck")
            seven.image = UIImage(named: "OrangeCheck")
            eight.image = UIImage(named: "OrangeCheck")
            nine.image = UIImage(named: "OrangeCheck")
            ten.image = UIImage(named: "OrangeCheck")
            eleven.image = UIImage(named: "OrangeCheck")
            twelve.image = UIImage(named: "OrangeCheck")
            thirteen.image = UIImage(named: "OrangeCheck")
            fourteen.image = UIImage(named: "OrangeCheck2")
            fifteen.image = UIImage(named: "OrangeCheck2")
            
        }
        
        if counter == 13 {
            
            one.image = UIImage(named: "OrangeCheck")
            two.image = UIImage(named: "OrangeCheck")
            three.image = UIImage(named: "OrangeCheck")
            four.image = UIImage(named: "OrangeCheck")
            five.image = UIImage(named: "OrangeCheck")
            six.image = UIImage(named: "OrangeCheck")
            seven.image = UIImage(named: "OrangeCheck")
            eight.image = UIImage(named: "OrangeCheck")
            nine.image = UIImage(named: "OrangeCheck")
            ten.image = UIImage(named: "OrangeCheck")
            eleven.image = UIImage(named: "OrangeCheck")
            twelve.image = UIImage(named: "OrangeCheck")
            thirteen.image = UIImage(named: "OrangeCheck")
            fourteen.image = UIImage(named: "OrangeCheck2")
            fifteen.image = UIImage(named: "OrangeCheck2")
        }
        
        if counter == 14 {
            
            one.image = UIImage(named: "OrangeCheck")
            two.image = UIImage(named: "OrangeCheck")
            three.image = UIImage(named: "OrangeCheck")
            four.image = UIImage(named: "OrangeCheck")
            five.image = UIImage(named: "OrangeCheck")
            six.image = UIImage(named: "OrangeCheck")
            seven.image = UIImage(named: "OrangeCheck")
            eight.image = UIImage(named: "OrangeCheck")
            nine.image = UIImage(named: "OrangeCheck")
            ten.image = UIImage(named: "OrangeCheck")
            eleven.image = UIImage(named: "OrangeCheck")
            twelve.image = UIImage(named: "OrangeCheck")
            thirteen.image = UIImage(named: "OrangeCheck")
            fourteen.image = UIImage(named: "OrangeCheck")
            fifteen.image = UIImage(named: "OrangeCheck")
            
        }
        
        quotetext.addCharacterSpacing()

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

extension UILabel {
    func addCharacterSpacing() {
        if let labelText = text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(NSAttributedStringKey.kern, value: 1.2, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}
