//
//  SubscriptionsViewController.swift
//  Eat
//
//  Created by Alek Matthiessen on 6/30/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

class SubscriptionsViewController: UIViewController {

    @IBOutlet weak var tapbilling: UIButton!
    @IBOutlet weak var tapprivacy: UIButton!
    @IBOutlet weak var tapterms: UIButton!
    @IBAction func tapBilling(_ sender: Any) {
        
        if let url = NSURL(string: "https://www.tryeatfree.com/billing-terms.html"
            ) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    @IBAction func tapPrivacy(_ sender: Any) {
        
        if let url = NSURL(string: "https://www.tryeatfree.com/privacy-policy.html"
            ) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBAction func tapTerms(_ sender: Any) {
        
        if let url = NSURL(string: "https://www.tryeatfree.com/terms.html"
            ) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let buttonTitleStr = NSMutableAttributedString(string:"Terms & Conditions", attributes:attrs)
        attributedString.append(buttonTitleStr)
        
        let buttonTitleStr2 = NSMutableAttributedString(string:"Privacy Policy", attributes:attrs)
        attributedString2.append(buttonTitleStr2)
        
        let buttonTitleStr3 = NSMutableAttributedString(string:"Billing Terms", attributes:attrs)
        attributedString3.append(buttonTitleStr3)
        
    tapterms.setAttributedTitle(attributedString, for: .normal)
        
tapprivacy.setAttributedTitle(attributedString2, for: .normal)

    tapbilling.setAttributedTitle(attributedString3, for: .normal)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var attrs = [
        NSAttributedStringKey.foregroundColor : UIColor.gray,
        NSAttributedStringKey.underlineStyle : 1] as [NSAttributedStringKey : Any]
    
    var attributedString = NSMutableAttributedString(string:"")
    
    var attributedString2 = NSMutableAttributedString(string:"")

    
    var attributedString3 = NSMutableAttributedString(string:"")


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
