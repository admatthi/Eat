//
//  WorkoutOptionsViewController.swift
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

let bigblack = UIColor(red:0.18, green:0.18, blue:0.24, alpha:1.0)

var workoutids = [String]()
var titles = [String:String]()
var levels = [String:String]()
var descriptions = [String:String]()
var betterimages = [UIImage]()

var selectedworkout = String()

class WorkoutOptionsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        collectionView.layer.cornerRadius = 10.0
        collectionView.backgroundColor = bigblack
 


        self.becomeFirstResponder() // To get shake gesture

        // Do any additional setup after loading the view.
        
        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in

            DispatchQueue.main.async {
//                newuser = true

                self.performSegue(withIdentifier: "HomeToWorkouts", sender: self)
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


            queryforworkoutids { () -> () in
                
                self.queryforworkoutinfo()
            }

        }
//
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func queryforworkoutids(completed: @escaping (() -> ()) ) {
        
        
        workoutids.removeAll()
        titles.removeAll()
        levels.removeAll()
        descriptions.removeAll()
        betterimages.removeAll()
        
        betterimages.append(UIImage(named: "Export")!)
        betterimages.append(UIImage(named: "2-1")!)
        betterimages.append(UIImage(named: "3-1")!)
        betterimages.append(UIImage(named: "4-1")!)
        betterimages.append(UIImage(named: "5")!)
        
        var functioncounter = 0
        
            ref?.child("Workouts").observeSingleEvent(of: .value, with: { (snapshot) in
        
                    var value = snapshot.value as? NSDictionary
        
                    if let snapDict = snapshot.value as? [String:AnyObject] {
        
                        for each in snapDict {
        
                            let ids = each.key
        
                            workoutids.append(ids)
        
                            functioncounter += 1
        
                            if functioncounter == snapDict.count {
        
                                completed()
        
                            }
        
        
                        }
        
                    }
        
                })
        
    }
    
    func queryforworkoutinfo() {
        
        var functioncounter = 0
        
        for each in workoutids {
            
            ref?.child("Workouts").child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                if var activityvalue = value?["Title"] as? String {
                    
                    titles[each] = activityvalue
                    
                    
                }
                
                
                if var activityvalue = value?["Level"] as? String {
                    
                    levels[each] = activityvalue
                    
                    
                }
                
                
                if var activityvalue = value?["Description"] as? String {
                    
                    descriptions[each] = activityvalue
                    
                    
                }
                
                
                if var productimagee = value?["Image"] as? String {
                    
                    if productimagee.hasPrefix("http://") || productimagee.hasPrefix("https://") {
                        
                        let url = URL(string: productimagee)
                        
                        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                        
                        if data != nil {
                            
                            let productphoto = UIImage(data: (data)!)
                            
                            //                            matchimages[each] = self.maskRoundedImage(image: productphoto!, radius: 180.0)
                            let sizee = CGSize(width: 50, height: 50) // CGFloat, Double, Int
                            
//                            betterimages[each] = productphoto
                            
                            
                        }
                        
                        
                    }
                }
                
                functioncounter += 1
                if functioncounter == workoutids.count {
                    
                    self.collectionView.reloadData()
                }
            })
            
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        if titles.count > 0 {

            return titles.count

        } else {

            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Workouts", for: indexPath) as! WorkoutCategoryCollectionViewCell

        if titles.count > indexPath.row {
            
        cell.category.text = titles[workoutids[indexPath.row]]
        cell.difficulty.text = levels[workoutids[indexPath.row]]
        cell.intro.text = descriptions[workoutids[indexPath.row]]
        cell.backimage.image = betterimages[indexPath.row]
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedworkout = titles[workoutids[indexPath.row]]!
        selectedexercise = workoutids[indexPath.row]
        self.performSegue(withIdentifier: "HomeToWorkout", sender: self)
        
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
