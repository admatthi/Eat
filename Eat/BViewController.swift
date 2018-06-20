//
//  BViewController.swift
//  Eat
//
//  Created by Alek Matthiessen on 5/20/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import FBSDKCoreKit

let darkblue = UIColor(red:0.62, green:0.64, blue:0.74, alpha:1.0)
let mygreen = UIColor(red:0.17, green:0.88, blue:0.70, alpha:1.0)

class BViewController: UIViewController {

    var b1pressed = Bool()
    var b2pressed = Bool()
    var b3pressed = Bool()
    var b4pressed = Bool()
    
    @IBOutlet weak var tapbutton1: UIButton!
    @IBOutlet weak var tapbutton2: UIButton!
    @IBOutlet weak var tapbutton3: UIButton!
    @IBOutlet weak var tapbutton4: UIButton!
    
    @IBOutlet weak var tapwaist: UIButton!
    @IBOutlet weak var taparms: UIButton!
    @IBOutlet weak var tapthighs: UIButton!
    @IBOutlet weak var tapabs: UIButton!
    @IBOutlet weak var waist: UIImageView!
    @IBOutlet weak var arms: UIImageView!
    @IBOutlet weak var thighs: UIImageView!
    @IBOutlet weak var abs: UIImageView!
    @IBAction func tapWaist(_ sender: Any) {
        
        if waistb {
            
            waisttapped()
            
        } else {
            
            waistuntapped()
        }
    }
    @IBAction func tapArms(_ sender: Any) {
        
        if armsb {
            
            armstapped()
            
        } else {
            
            armsuntapped()
        }
    }
    @IBAction func tapThighs(_ sender: Any) {
        
        if thighsb {
            
            thighstapped()
            
        } else {
            
            thighsuntapped()
        }
    }
    @IBAction func tapAbs(_ sender: Any) {
        
        if absb {
            
            abstapped()
            
        } else {
            
            absuntapped()
        }
    }
    @IBAction func tapGetStarted(_ sender: Any) {
     
        if thighsb {
            
            thighstapped()
            
        } else {
            
            thighsuntapped()
        }
    }
    
    var absb = Bool()
    var thighsb = Bool()
    var armsb = Bool()
    var waistb = Bool()
    
    func absuntapped() {
        
        abs.image = UIImage(named: "Abs")
        tapabs.setBackgroundImage(UIImage(named: "GreyOutline"), for: .normal)
        tapabs.setTitleColor(darkblue, for: .normal)
        
        absb = true

    }
    
    func abstapped() {
        
        abs.image = UIImage(named: "AbsColored")
        tapabs.setBackgroundImage(UIImage(named: "ColoredOutline"), for: .normal)
        tapabs.setTitleColor(.white, for: .normal)
     
        absb = false

    }
    
    func waistuntapped() {
        
        waist.image = UIImage(named: "Waist")
        tapwaist.setBackgroundImage(UIImage(named: "GreyOutline"), for: .normal)
        tapwaist.setTitleColor(darkblue, for: .normal)
        
        waistb = true
        
    }
    
    func waisttapped() {
        
        waist.image = UIImage(named: "WaistColored")
        tapwaist.setBackgroundImage(UIImage(named: "ColoredOutline"), for: .normal)
        tapwaist.setTitleColor(.white, for: .normal)
        
        waistb = false
        
    }
    
    func armsuntapped() {
        
        arms.image = UIImage(named: "Arms")
        taparms.setBackgroundImage(UIImage(named: "GreyOutline"), for: .normal)
        taparms.setTitleColor(darkblue, for: .normal)
        
        armsb = true
        
    }
    
    func armstapped() {
        
        arms.image = UIImage(named: "ArmsColored")
        taparms.setBackgroundImage(UIImage(named: "ColoredOutline"), for: .normal)
        taparms.setTitleColor(.white, for: .normal)
        
        armsb = false
        
    }
    
    func thighsuntapped() {
        
        thighs.image = UIImage(named: "Thighs")
        tapthighs.setBackgroundImage(UIImage(named: "GreyOutline"), for: .normal)
        tapthighs.setTitleColor(darkblue, for: .normal)
        
        thighsb = true
        
    }
    
    func thighstapped() {
        
        thighs.image = UIImage(named: "ThighsColored")
        tapthighs.setBackgroundImage(UIImage(named: "ColoredOutline"), for: .normal)
        tapthighs.setTitleColor(.white, for: .normal)
        
        thighsb = false
        
    }
    
    @IBAction func tapButton1(_ sender: Any) {
        
        //        if b1pressed {
        //
        //            tapbutton1.alpha = 1.0
        //            b1pressed = false
        //
        //
        //        } else {
        //
        //            tapbutton1.alpha = 0.5
        //
        //            b1pressed = true
        //        }
        

        tapbutton1.setBackgroundImage(UIImage(named:"ColoredButton"), for: .normal)
        tapbutton1.setTitleColor(.white, for: .normal)
        tapbutton2.setTitleColor(.black, for: .normal)
        tapbutton3.setTitleColor(.black, for: .normal)
        tapbutton2.setBackgroundImage(UIImage(named:"WhiteButton"), for: .normal)
        tapbutton3.setBackgroundImage(UIImage(named:"WhiteButton"), for: .normal)
        
        
    }
    @IBAction func tapButton2(_ sender: Any) {
        
        tapbutton2.setBackgroundImage(UIImage(named:"ColoredButton"), for: .normal)
        tapbutton2.setTitleColor(.white, for: .normal)
        tapbutton1.setTitleColor(.black, for: .normal)
        tapbutton3.setTitleColor(.black, for: .normal)
        tapbutton1.setBackgroundImage(UIImage(named:"WhiteButton"), for: .normal)
        tapbutton3.setBackgroundImage(UIImage(named:"WhiteButton"), for: .normal)
        
        
    }
    @IBAction func tapButton3(_ sender: Any) {
        
        tapbutton3.setBackgroundImage(UIImage(named:"ColoredButton"), for: .normal)
        tapbutton3.setTitleColor(.white, for: .normal)
        tapbutton2.setTitleColor(.black, for: .normal)
        tapbutton1.setTitleColor(.black, for: .normal)
        tapbutton2.setBackgroundImage(UIImage(named:"WhiteButton"), for: .normal)
        tapbutton1.setBackgroundImage(UIImage(named:"WhiteButton"), for: .normal)
        
        
    }
    @IBAction func tapButton4(_ sender: Any) {
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FBSDKAppEvents.logEvent("Second Screen")
        
        b1pressed = true
        b2pressed = true
        b3pressed = true
        b4pressed = true
        
        absb = true
        thighsb = true
        waistb = true
        armsb = true
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

