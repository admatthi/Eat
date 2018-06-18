//
//  PulseViewController.swift
//  Eat
//
//  Created by Alek Matthiessen on 5/31/18.
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

var screenshot = UIImage()

var goal1 = String()
var goal2 = String()
var goal3 = String()
var goal4 = String()
var goal5 = String()
var goal6 = String()
var goal7 = String()
var goal8 = String()
var goal9 = String()
var goal10 = String()
var goal11 = String()
var goal12 = String()
var goal13 = String()
var caloriesgoal = String()

var todayscalories = String()
var oldfat = String()
var oldsatfat = String()
var oldcholesterol = String()
var oldsodium = String()
var oldcarbs = String()
var oldprotein = String()
var today7 = String()
var today8 = String()
var today9 = String()
var oldfat0 = String()
var oldfat1 = String()
var oldfat2 = String()
var oldfat3 = String()

var viewingtoday = Bool()
var tapped = Bool()

var newuser = Bool()

class PulseViewController: UIViewController {

    @IBOutlet weak var goallabel: UILabel!

    @IBOutlet weak var remaininglabel: UILabel!
    func loadtodaysvalues() {
        
        calories.text = todayscalories
        fat.text = "\(oldfat)g"
        satured.text = "\(oldsatfat)g"
        cholesterol.text = "\(oldcholesterol)mg"
        sodium.text = "\(oldsodium)mg"
        carbs.text = "\(oldcarbs)g"
        protein.text = "\(oldprotein)g"

        
        
    }
    
    @IBOutlet weak var background: UILabel!
    @IBOutlet weak var calories: UILabel!

    @IBOutlet weak var c: UILabel!
    @IBOutlet weak var tf: UILabel!
    @IBOutlet weak var s: UILabel!
    @IBOutlet weak var ch: UILabel!
    @IBOutlet weak var so: UILabel!
    @IBOutlet weak var tc: UILabel!
    @IBOutlet weak var p: UILabel!
    
    func defaulttoday() {
        
        todayscalories = "0"
        oldfat = "0"
        oldsatfat = "0"
        oldcholesterol = "0"
        oldsodium = "0"
        oldcarbs = "0"
        oldprotein = "0"

    }
    

    @IBOutlet weak var fat: UILabel!
    @IBOutlet weak var satured: UILabel!
    @IBOutlet weak var cholesterol: UILabel!
    @IBOutlet weak var sodium: UILabel!
    @IBOutlet weak var carbs: UILabel!
    @IBOutlet weak var protein: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        self.becomeFirstResponder() // To get shake gesture

        c.addCharacterSpacing()
        tf.addCharacterSpacing()
        s.addCharacterSpacing()
        ch.addCharacterSpacing()
        so.addCharacterSpacing()
        tc.addCharacterSpacing()
        p.addCharacterSpacing()
        // Do any additional setup after loading the view.
        
        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in
            
            DispatchQueue.main.async {
                newuser = true

                self.performSegue(withIdentifier: "PulseToHome", sender: self)
            }
            
        } else {
            
            newuser = false
            // Do any additional setup after loading the view.
            
            let date = Date()
            let calendar = Calendar.current
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yy"
            todaysdate =  dateFormatter.string(from: date)
            
            uid = (Auth.auth().currentUser?.uid)!
            
            viewingtoday = true
            defaulttoday()
            loadtodaysvalues()
            queryfortodaysvalues()
            
        }
    }
    
    func queryfortodaysvalues() {
        
ref?.child("OurUsers").child(uid).child(todaysdate).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if var activityvalue = value?["Calories"] as? String {
                
                todayscalories = activityvalue
                self.loadtodaysvalues()
            }
            
            if var activityvalue = value?["Fat"] as? String {
                
                oldfat = activityvalue
                self.loadtodaysvalues()
            }
            
            if var activityvalue = value?["SatFat"] as? String {
                
                oldsatfat = activityvalue
                self.loadtodaysvalues()
            }
            
            if var activityvalue = value?["Cholesterol"] as? String {
                
                oldcholesterol = activityvalue
                self.loadtodaysvalues()
            }
            if var activityvalue = value?["Sodium"] as? String {
                
                oldsodium = activityvalue
                self.loadtodaysvalues()
            }
            if var activityvalue = value?["Carbs"] as? String {
                
                oldcarbs = activityvalue
                self.loadtodaysvalues()
                
            }
            if var activityvalue = value?["Protein"] as? String {
                
                oldprotein = activityvalue
                self.loadtodaysvalues()
            }

            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    // Enable detection of shake motion
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            
            takeScreenshot(true)
           showalert()
            
        }
    }
    
    
    func showalert() {
        
        let alert = UIAlertController(title: "Shake To Report", message: "Please report any issues you found!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Send Feedback", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "Feedback") as! FeedbackViewController
                self.present(vc, animated: true, completion: nil)

            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    
    }
    
    open func takeScreenshot(_ shouldSave: Bool = true) -> UIImage? {
        var screenshotImage :UIImage?
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        guard let context = UIGraphicsGetCurrentContext() else {return nil}
        layer.render(in:context)
        screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let image = screenshotImage, shouldSave {
            
            screenshot = image
            
        }
        return screenshotImage
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
            attributedString.addAttribute(NSAttributedStringKey.kern, value: 2.0, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}
