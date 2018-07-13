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

class ReaderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var titlelabel: UILabel!
    @IBAction func tapPrevious(_ sender: Any) {
    }
    @IBAction func tapNext(_ sender: Any) {
    }
    @IBOutlet weak var headerlabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var ref: DatabaseReference?
    var category = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        titlelabel.text = selectedtitle
        
//        wtf()
        
                
        if selfhelp {
            
            category = "SelfHelpBooks"
            whatthehell()

            
        } else {
            
            category = "Books"
            whatthehell()
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func whatthehell() {
        
        quote.removeAll()
        
        ref?.child(category).child(selectedbookid).child("Summary").child("1").observeSingleEvent(of: .value, with: { (snapshot) in
            
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
            
            self.tableView.reloadData()
        })
        
        
    }
    
    func wtf() {
        
        var functioncounter = 1
        
        while functioncounter < 15 {
            
            ref?.child("Books").child(selectedbookid).child("Summary").child("\(functioncounter)").observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                if var activityvalue = value?["Title"] as? String {
                    
                    self.headerlabel.text = activityvalue
                    
                }
                
                
                if var activityvalue2 = value?["1"] as? String {
                    
                    quote.append(activityvalue2)
                }
                
                functioncounter += 1
                
                self.tableView.reloadData()
            })
            
        }
        
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if quote.count > 0 {
            
            return quote.count
            
        } else {
            
            return 1
        }
        
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Quote", for: indexPath) as! ReadTableViewCell
        
        if quote.count > indexPath.row {
            
            cell.quotelabel.text = "\(quote[indexPath.row])"
            cell.quotenumber.text = "\(indexPath.row+1))"
            
        }
        cell.BACKLABEL.layer.cornerRadius = 5.0
        cell.BACKLABEL.layer.masksToBounds = true
        return cell
        
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
