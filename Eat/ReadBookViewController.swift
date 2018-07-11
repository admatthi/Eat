//
//  ReadBookViewController.swift
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

class ReadBookViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var titlelabel: UILabel!
    @IBAction func tapPrevious(_ sender: Any) {
    }
    @IBAction func tapNext(_ sender: Any) {
    }
    @IBOutlet weak var headerlabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()

        titlelabel.text = selectedtitle
        
        queryforbookinfo()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func queryforbookinfo() {
        
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
            
            cell.quotelabel.text = quote[indexPath.row]

        }
        
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
