//
//  PostPhotoViewController.swift
//  Eat
//
//  Created by Alek Matthiessen on 6/2/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase
import FirebaseStorage

var unitofmeasure = String()

class PostPhotoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var tapservingsize: UIButton!
    @IBOutlet weak var tapfood: UIButton!
    @IBOutlet weak var tapgroup: UIButton!
    @IBOutlet weak var tapsubmit: UIButton!
    @IBOutlet weak var tapx: UIButton!
    
    @IBOutlet weak var nutrient1: UILabel!
    @IBOutlet weak var ourimage: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!

    @IBOutlet weak var nutrient2: UILabel!
    @IBOutlet weak var nutrient3: UILabel!
    @IBOutlet weak var value1: UILabel!
    @IBOutlet weak var value2: UILabel!
    @IBOutlet weak var value3: UILabel!
    @IBOutlet weak var value4: UILabel!
    @IBOutlet weak var value5: UILabel!
    @IBOutlet weak var value6: UILabel!
    @IBOutlet weak var value7: UILabel!
    
    @IBOutlet weak var value11: UILabel!
    @IBOutlet weak var value22: UILabel!
    @IBOutlet weak var value33: UILabel!
    @IBOutlet weak var value44: UILabel!
    @IBOutlet weak var value55: UILabel!
    @IBOutlet weak var value66: UILabel!
    @IBOutlet weak var value77: UILabel!

    @IBAction func tapX(_ sender: Any) {
        
        self.performSegue(withIdentifier: "PostToPre", sender: self)
        
    }
    
    @IBAction func tapServings(_ sender: Any) {
        
        groupressed = false
        foodpressed = false
        servingspressed = true
        editgroup()
    }
    @IBAction func tapFood(_ sender: Any) {
        
        groupressed = false
        foodpressed = true
        servingspressed = false
        editgroup()
    }
    @IBAction func tapGroup(_ sender: Any) {
        
        groupressed = true
        foodpressed = false
        servingspressed = false
        editgroup()
    }
    
    @IBAction func tapSubmit(_ sender: Any) {
        
        if newuser == true {
            
            self.performSegue(withIdentifier: "PostToPurchase", sender: self)
            
        } else {
            
            let storage = Storage.storage()
            let storageRef = storage.reference()
            let currentUser = Auth.auth().currentUser
            
            
            let metaData = StorageMetadata()
            
            metaData.contentType = "image/jpg"
            
            counter += 1
            
            let filePath = "\(uid)\(counter)"
            
            //        let filePath = "\(counter)"
            
            storageRef.child(filePath).putData(logoimagedata, metadata: metaData){(metaData,error) in
                
                if let error = error {
                    
                    print(error.localizedDescription)
                    
                    return
                    
                } else {
                    
                    // store download url
                    logodownloadURL = metaData!.downloadURL()!.absoluteString
                    
                    
                    let currentUser = Auth.auth().currentUser
                    
                    var uid = String()
                    
                    uid = currentUser!.uid
                    
                    ref = Database.database().reference()
                    
                    ref?.child("Users").child(uid).child(todaysdate).childByAutoId().updateChildValues(["Image": "\(logodownloadURL)"])
                    
                    self.storenewnutrientvalues()
                    
                    
                }
                
            }
        }
       
        
    }
        
        func postphoto() {
            
            ourimage.image = newimage
            tapsubmit.alpha = 1
            pickerView.alpha = 0
            tapgroup.alpha = 1
            tapfood.alpha = 1
            tapservingsize.alpha = 1
            
//            value1.alpha = 1
//            value2.alpha = 1
//            value3.alpha = 1
//            value4.alpha = 1
//            value5.alpha = 1
//            value6.alpha = 1
//            value7.alpha = 1
//            value11.alpha = 1
//            value22.alpha = 1
//            value33.alpha = 1
//            value44.alpha = 1
//            value55.alpha = 1
//            value66.alpha = 1
//            value77.alpha = 1
        }
        

        
    func editgroup() {
            
            tapsubmit.alpha = 0
            pickerView.alpha = 1
            pickerView.reloadAllComponents()
//            value1.alpha = 0
//            value2.alpha = 0
//            value3.alpha = 0
//            value4.alpha = 0
//            value5.alpha = 0
//            value6.alpha = 0
//            value7.alpha = 0
//            value11.alpha = 0
//            value22.alpha = 0
//            value33.alpha = 0
//            value44.alpha = 0
//            value55.alpha = 0
//            value66.alpha = 0
//            value77.alpha = 0
        }
    
        func appendservings() {
            
            servingoptions.append("1")
            servingoptions.append("2")
            servingoptions.append("3")
            servingoptions.append("4")
            servingoptions.append("5")
            servingoptions.append("6")
            servingoptions.append("7")
            servingoptions.append("8")
            servingoptions.append("9")
        }
        
        func loadfirstbuttons() {
            
            if groups[0] != nil && foods[0] != nil && groups.count > 0 && foods.count > 0  {
                self.tapgroup.setTitle(groups.first, for: .normal)
                self.tapfood.setTitle(foods.first, for: .normal)
                self.tapservingsize.setTitle("\(servingoptions[0]) \(unitofmeasure)", for: .normal)
                
            }
                
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ourimage.layer.masksToBounds = false
        ourimage.layer.cornerRadius = ourimage.frame.height/2
        ourimage.clipsToBounds = true
        
        postphoto()
        
        appendservings()

        selectedservings = "1"
        multiplynutrition()
        
        loadfirstbuttons()
        
        ref = Database.database().reference()

    }
    
            func numberOfComponents(in pickerView: UIPickerView) -> Int {
                return 1
            }
            func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
                
                if groupressed {
                    
                    
                    return groups[row]
                    
                    
                } else {
                    
                    if foodpressed {
                        
                        return foods[row]
                        
                    } else {
                        
                        if servingspressed {
                            
                            return servingoptions[row]
                            
                            
                        } else {
                            
                            return ""
                        }
                    }
                }
            }
            
            func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
                
                if groupressed {
                    
                    return groups.count
                    
                    
                } else {
                    
                    if foodpressed {
                        
                        return foods.count
                        
                    } else {
                        
                        if servingspressed {
                            
                            return servingoptions.count
                            
                            
                        } else {
                            
                            return 0
                        }
                    }
                }
                
            }
            
            
            func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
                
                
                if groupressed {
                    
                    selectedgroup = groups[row]
                    
                    selectedfood = foods[0]
                    
                    tapgroup.setTitle(selectedgroup, for: .normal)
                    
                    groupressed = false
                    foodpressed = false
                    servingspressed = false
                    
                    foods.removeAll()
                    
                    loadfoods()
                    
                } else {
                    
                    if foodpressed {
                        
                        selectedgroup = (tapgroup.titleLabel?.text!)!
                        
                        selectedfood = foods[row]
                        
                        tapfood.setTitle(selectedfood, for: .normal)
                        
                        groupressed = false
                        foodpressed = false
                        servingspressed = false
                        
                        loadfoods2()
                        
                    } else {
                        
                        if servingspressed {
                            
                            selectedgroup = (tapgroup.titleLabel?.text)!
                            selectedfood = (tapfood.titleLabel?.text!)!
                            
                            selectedservings = servingoptions[row]
                            
                            tapservingsize.setTitle("\(selectedservings ) \(unitofmeasure)", for: .normal)
                            groupressed = false
                            foodpressed = false
                            servingspressed = false
                            
                            multiplynutrition()
                            
                        }
                    }
                }
                
                postphoto()
                
            }
            

            
            func loadfoods() {
                
                var groupcounter = 0
                var foodcounter = 0
                for group in (results?.results)! {
                    
                    if groupcounter == groups.index(of: selectedgroup) as! Int {
                        
                        
                        for item in group.items {
                            
                            foods.append(item.name!)
                            
                            selectedfood = foods[0]
                            
                            tapfood.setTitle(selectedfood, for: .normal)
                            
                            if foodcounter == foods.index(of: selectedfood) as! Int {
                                
                                for serving in item.servingSizes {
                                    
                                    unitofmeasure = serving.unit!
                                    
                                    unitofmeasure = unitofmeasure.components(separatedBy: " ").dropFirst().joined(separator: " ")
                                    
                                    tapservingsize.setTitle("\(selectedservings ) \(unitofmeasure)", for: .normal)

                                    var thisisit = serving.servingWeight
                                    
                                    if thisisit != nil {
                                        nutrients = item.nutrition
                                        
                                        if nutrients["totalCarbs"] != nil {
                                            
                                    
                                            var intcarbs = nutrients["totalCarbs"]! * thisisit!
                                            newcarbs = String(format: "%.1f", intcarbs * 1000)
                                            
                                        }
                                        if nutrients["protein"] != nil {
                                            
                                            var intprotein = nutrients["protein"]! * thisisit!
                                            newprotein = String(format: "%.1f", intprotein * 1000)
                                            
                                        }
                                        
                                        if nutrients["calories"] != nil {
                                            
                                            var intcalories = nutrients["calories"]! * thisisit!
                                            newcalories = String(format: "%.1f", intcalories)
                                            
                                        }
                                        
                                        
                                        if nutrients["totalFat"] != nil {
                                            
                                            var intfat = nutrients["totalFat"]! * thisisit!
                                            newfats = String(format: "%.1f", intfat)
                                            
                                        }
                                        
                                        multiplynutrition()
                                    } else {
                                        
                                        nutrients = item.nutrition
                                        
                                        if nutrients["totalCarbs"] != nil {
                                            
                                            var intcarbs = nutrients["totalCarbs"]!
                                            newcarbs = String(format: "%.1f", intcarbs * 1000)
                                            
                                        }
                                        if nutrients["protein"] != nil {
                                            
                                            var intprotein = nutrients["protein"]!
                                            newprotein = String(format: "%.1f", intprotein * 1000)
                                            
                                        }
                                        
                                        if nutrients["calories"] != nil {
                                            
                                            var intcalories = nutrients["calories"]!
                                            newcalories = String(format: "%.1f", intcalories)
                                            
                                        }
                                        
                                        if nutrients["totalFat"] != nil {
                                            
                                            var intfat = nutrients["totalFat"]!
                                            newfats = String(format: "%.1f", intfat)
                                            
                                        }
                                        
                                        multiplynutrition()
                                    }
                                    
                                    
                                    
                                    
                                }
                                
                                
                            }
                            foodcounter += 1
                            
                        }
                    }
                    
                    groupcounter += 1
                    
                }
                
            }
            
            
            
            func loadfoods2() {
                
                var groupcounter = 0
                var foodcounter = 0
                for group in (results?.results)! {
                    
                    if groupcounter == groups.index(of: selectedgroup) as! Int {
                        
                        
                        for item in group.items {
                            
                            foods.append(item.name!)
                            
                            
                            tapfood.setTitle(selectedfood, for: .normal)
                            
                            if foodcounter == foods.index(of: selectedfood) as! Int {
                                
                                var servingcounter = 0
                                
                                for serving in item.servingSizes {
                                    
                                    if servingcounter == 0 {
                                        var thisisit = serving.servingWeight
                                        unitofmeasure = serving.unit!
                                        
                                        unitofmeasure = unitofmeasure.components(separatedBy: " ").dropFirst().joined(separator: " ")
                                        
                                        tapservingsize.setTitle("\(selectedservings ) \(unitofmeasure)", for: .normal)

                                        if thisisit != nil {
                                            nutrients = item.nutrition
                                            
                                            if nutrients["totalCarbs"] != nil {
                                                
                                                var intcarbs = nutrients["totalCarbs"]! * thisisit!
                                                newcarbs = String(format: "%.1f", intcarbs * 1000)
                                                
                                                
                                                
                                            }
                                            if nutrients["protein"] != nil {
                                                
                                                var intprotein = nutrients["protein"]! * thisisit!
                                                newprotein = String(format: "%.1f", intprotein * 1000)
                                                
                                            }
                                            
                                            if nutrients["calories"] != nil {
                                                
                                                var intcalories = nutrients["calories"]! * thisisit!
                                                newcalories = String(format: "%.1f", intcalories)
                                                
                                            }
                                            
                                            if nutrients["totalFat"] != nil {
                                                
                                                var intfat = nutrients["totalFat"]! * thisisit!
                                                newfats = String(format: "%.1f", intfat)
                                                
                                            }
                                            
                                            multiplynutrition()
                                            
                                        } else {
                                            
                                            nutrients = item.nutrition
                                            
                                            if nutrients["totalCarbs"] != nil {
                                                
                                                var intcarbs = nutrients["totalCarbs"]!
                                                newcarbs = String(format: "%.1f", intcarbs * 1000)
                                                
                                            }
                                            if nutrients["protein"] != nil {
                                                
                                                var intprotein = nutrients["protein"]!
                                                newprotein = String(format: "%.1f", intprotein * 1000)
                                                
                                            }
                                            
                                            if nutrients["calories"] != nil {
                                                
                                                var intcalories = nutrients["calories"]!
                                                newcalories = String(format: "%.1f", intcalories)
                                                
                                            }
                                            
                                            
                                            if nutrients["totalFat"] != nil {
                                                
                                                var intfat = nutrients["totalFat"]!
                                                newfats = String(format: "%.1f", intfat)
                                                
                                            }
                                            
                                            multiplynutrition()
                                        }
                                        
                                    }
                                    
                                    servingcounter += 1
                                }
                                
                                
                            }
                            foodcounter += 1
                            
                        }
                    }
                    
                    groupcounter += 1
                    
                }
                
            }
            
            func multiplynutrition() {
                
                
                newcarbs = String(format: "%.1f", Double(newcarbs)! * Double(selectedservings)!)
                
                newprotein = String(format: "%.1f", Double(newprotein)! * Double(selectedservings)!)
                
                newcalories = String(format: "%.1f", Double(newcalories)! * Double(selectedservings)!)
                
                newfats = String(format: "%.1f", Double(newfats)! * Double(selectedservings)!)
                
                value11.text = newcalories
                value22.text = newprotein
                value33.text = newcarbs
                value44.text = newfats
            }
            
            func storenewnutrientvalues() {
                
                var newcaloriess = Double(todayscalories)! + Double(newcalories)!
                var new1 = Double(today1)! + Double(newprotein)!
                var new2 = Double(today2)! + Double(newcarbs)!
                var new3 = Double(today3)! + Double(newfats)!
                var new4 = Double(today4)! + Double(newpotassium)!
                var new5 = Double(today5)! + Double(newsodium)!
                var new6 = Double(today6)! + Double(newcholesterol)!
                var new7 = Double(today7)! + Double(newzinc)!
                var new8 = Double(today8)! + Double(newfiber)!
                var new9 = Double(today9)! + Double(newvitaminD)!
                var new10 = Double(today10)! + Double(newseleneium)!
                var new11 = Double(today11)! + Double(newiron)!
                var new12 = Double(today12)! + Double(newvitamina)!
                
                ref?.child("OurUsers").child(uid).child(todaysdate).updateChildValues(["Calories" : String(newcaloriess), "Protein" : String(new1), "Carbs" : String(new2), "Fats" : String(new3), "Potassium" : String(new4), "Sodium" : String(new5), "Cholesterol" : String(new6), "Zinc" : String(new7), "Fiber" : String(new8), "Vitamin D" : String(new9), "Selenium" : String(new10), "Iron" : String(new11), "Vitamin A" : String(new12)])
                
                
                DispatchQueue.main.async {
                    
                    self.performSegue(withIdentifier: "PostToHome", sender: self)
                    
                }
            }
            
        }


    

