//
//  FavoritesViewController.swift
//  Eat
//
//  Created by Alek Matthiessen on 7/16/18.
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

var favoriteids = [String]()
var favorites = [String]()

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        ref = Database.database().reference()

        queryforfavoriteids { () -> () in
            
            self.queryfordata()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func queryforfavoriteids(completed: @escaping (() -> ()) ) {
        
        var functioncounter = 0
        
        favoriteids.removeAll()
        
        
        ref?.child("Users").child(uid).child("Favorites").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for each in snapDict {
                    
                    let ids = each.key
                    
                    favoriteids.append(ids)
                    
                    functioncounter += 1
                    
                    if functioncounter == snapDict.count {
                        
                        completed()
                        
                    }
                    
                    
                }
                
            }
            
        })
        
        
    }
    
    func queryfordata() {
        
        var functioncounter = 0
        
        favorites.removeAll()
        
        for each in favoriteids {
        ref?.child("Users").child(uid).child("Favorites").child(each).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            
            if var activityvalue = value?["Text"] as? String {
                
                favorites.append(activityvalue)
                
                functioncounter += 1

            }
            
            if functioncounter == favoriteids.count {
                
                self.tableView.reloadData()
            }
            
            })
            
            

        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if favorites.count > 0 {
            
            return favorites.count

        } else {
            
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Favorites", for: indexPath) as! FavoritesTableViewCell
        
        if favorites.count > indexPath.row {
            
            cell.favoritelabel.text = favorites[indexPath.row]
        } else {
            
            cell.favoritelabel.text = "You have no favorites"

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
