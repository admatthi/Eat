//
//  BookOverviewViewController.swift
//  Eat
//
//  Created by Alek Matthiessen on 7/12/18.
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

class BookOverviewViewController: UIViewController {

    @IBOutlet weak var keyinsights: UILabel!
    @IBAction func tapStartReading(_ sender: Any) {
        
        if purchased {
            
                self.performSegue(withIdentifier: "BookOverviewToRead", sender: self)
            
        } else {
            
            self.performSegue(withIdentifier: "BookOverviewToPurchase", sender: self)
        }
        
    }
    
    @IBOutlet weak var tapstart: UIButton!
    @IBOutlet weak var descriptionlabel: UILabel!
    @IBOutlet weak var tapstartreading: UIButton!
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var abouttheauthor: UILabel!
    @IBOutlet weak var reviewer3: UILabel!
    @IBOutlet weak var review3: UILabel!
    @IBOutlet weak var reviewer2: UILabel!
    @IBOutlet weak var review2: UILabel!
    @IBOutlet weak var reviewer1: UILabel!
    @IBOutlet weak var review1: UILabel!
    @IBOutlet weak var author: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()

        titlelabel.text = selectedtitle
        author.text = selectedauthor
        cover.image = selectedimage
        
        queryforreviewinfo()
        
        cover.layer.cornerRadius = 10.0
        cover.layer.masksToBounds = true
        
        
        if purchased {
            
            tapstart.setTitle("Start Now", for: .normal)
            
        } else {
            
            tapstart.setTitle("Start Your Free 7-Day Trial Now", for: .normal)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func queryforreviewinfo() {
        
        var functioncounter = 0
        
            ref?.child("AllBooks").child(selectedbookid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                if var activityvalue2 = value?["AboutAuthor"] as? String {
                    
//                    self.abouttheauthor.text = activityvalue2
                }
                
                if var activityvalue2 = value?["Insights"] as? String {
                    
                    self.keyinsights.text = "\(activityvalue2) Key Snippets"
                }
                
                
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
