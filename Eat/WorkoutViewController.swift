//
//  WorkoutViewController.swift
//  Eat
//
//  Created by Alek Matthiessen on 6/17/18.
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

var exerciseids = [String]()
var etitles = [String:String]()
var setsreps = [String:String]()
var rest = [String:String]()
var image1 = [String:UIImage]()
var image2 = [String:UIImage]()

var selectedexercise = String()

class WorkoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var musclegrouplabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        tableView.reloadData()
        
        musclegrouplabel.text = selectedworkout
        
        queryforexerciseids { () -> () in
            
            self.queryforexerciseinfo()
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func queryforexerciseids(completed: @escaping (() -> ()) ) {
        
        exerciseids.removeAll()
        etitles.removeAll()
        image1.removeAll()
        image2.removeAll()
        setsreps.removeAll()
        rest.removeAll()
        var functioncounter = 0
        
        ref?.child("Exercises").child(selectedexercise).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for each in snapDict {
                    
                    let ids = each.key
                    
                    exerciseids.append(ids)
                    
                    functioncounter += 1
                    
                    if functioncounter == snapDict.count {
                        
                        completed()
                        
                    }
                    
                    
                }
                
            }
            
        })
        
    }
    
    func queryforexerciseinfo() {
        
        var functioncounter = 0
        
        for each in exerciseids {
            
            ref?.child("Exercises").child(selectedexercise).child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                if var activityvalue = value?["Title"] as? String {
                    
                    etitles[each] = activityvalue
                    
                    
                }
                
                
                if var activityvalue = value?["setsreps"] as? String {
                    
                    setsreps[each] = activityvalue
                    
                    
                }
                
                
                if var activityvalue = value?["rest"] as? String {
                    
                    rest[each] = activityvalue
                    
                    
                }
                
                
                if var productimagee = value?["Image1"] as? String {
                    
                    if productimagee.hasPrefix("http://") || productimagee.hasPrefix("https://") {
                        
                        let url = URL(string: productimagee)
                        
                        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                        
                        if data != nil {
                            
                            let productphoto = UIImage(data: (data)!)
                            
                            //                            matchimages[each] = self.maskRoundedImage(image: productphoto!, radius: 180.0)
                            let sizee = CGSize(width: 50, height: 50) // CGFloat, Double, Int
                            
                            image1[each] = productphoto
                            //                            matchimages[each] = productphoto!
                            
                            self.tableView.reloadData()
                            
                        }
                        
                        
                    }
                }
                
                
                if var productimagee = value?["Image2"] as? String {
                    
                    if productimagee.hasPrefix("http://") || productimagee.hasPrefix("https://") {
                        
                        let url = URL(string: productimagee)
                        
                        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                        
                        if data != nil {
                            
                            let productphoto = UIImage(data: (data)!)
                            
                            //                            matchimages[each] = self.maskRoundedImage(image: productphoto!, radius: 180.0)
                            let sizee = CGSize(width: 50, height: 50) // CGFloat, Double, Int
                            
                            image2[each] = productphoto
                            //                            matchimages[each] = productphoto!
                            self.tableView.reloadData()

                            
                        }
                        
                        
                    }
                }
                
                self.tableView.reloadData()

                functioncounter += 1
                if functioncounter == exerciseids.count {
                    
                    self.tableView.reloadData()
                }
            })
            
            
        }
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if etitles.count > 0 {

            return etitles.count

        } else {

            return 1
        }
        
        
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Exercises", for: indexPath) as! WorkoutTableViewCell
        
        cell.photo1.layer.masksToBounds = true
        cell.photo1.layer.cornerRadius = cell.photo1.frame.height/2
        
        cell.photo2.layer.masksToBounds = true
        cell.photo2.layer.cornerRadius = cell.photo2.frame.height/2
        
        if etitles.count > indexPath.row {

            cell.title.text = etitles[exerciseids[indexPath.row]]

//            cell.rest.text = rest[exerciseids[indexPath.row]]
            cell.setsreps.text = setsreps[exerciseids[indexPath.row]]
            cell.photo1.image = image1[exerciseids[indexPath.row]]
            cell.photo2.image = image2[exerciseids[indexPath.row]]

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
