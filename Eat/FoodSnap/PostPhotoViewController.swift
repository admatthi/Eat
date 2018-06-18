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

    @IBOutlet weak var calories: UILabel!
    @IBOutlet weak var totalfat: UILabel!
    @IBOutlet weak var satfat: UILabel!
    @IBOutlet weak var transfat: UILabel!
    @IBOutlet weak var cholesterol: UILabel!
    @IBOutlet weak var sodium: UILabel!
    @IBOutlet weak var totalcarbs: UILabel!
    @IBOutlet weak var protein: UILabel!
    
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
        
//        if newuser == true {
//
//            self.performSegue(withIdentifier: "PostToPurchase", sender: self)
//
//        } else {
        
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
    @IBOutlet weak var background: UILabel!
    
    
    @IBOutlet weak var c: UILabel!
    @IBOutlet weak var tf: UILabel!
    @IBOutlet weak var s: UILabel!
    @IBOutlet weak var ch: UILabel!
    @IBOutlet weak var so: UILabel!
    @IBOutlet weak var tc: UILabel!
    @IBOutlet weak var p: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder() // To get shake gesture

        s.addCharacterSpacing()
        tf.addCharacterSpacing()
        s.addCharacterSpacing()
        ch.addCharacterSpacing()
        so.addCharacterSpacing()
        tc.addCharacterSpacing()
        p.addCharacterSpacing()
        
        ourimage.layer.masksToBounds = false
        ourimage.layer.cornerRadius = ourimage.frame.height/2
        ourimage.clipsToBounds = true
        
        postphoto()
        
        appendservings()

        selectedservings = "1"
        multiplynutrition()
        
        loadfirstbuttons()
        
        ref = Database.database().reference()
        
        background.layer.cornerRadius = 10.0
        background.clipsToBounds = true
        
        
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
                            
                            loadfoods2()
                            
                        }
                    }
                }
                
                postphoto()
                
            }
            

            
            func loadfoods() {
                
                defaultnutrientvalues()
                
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

                                    
                                    if serving.servingWeight != nil {
                                        
                                        thisisit = serving.servingWeight!

                                        nutrients = item.nutrition
                                        
                                        loadnutrientlabelswithservings()
                                        
                                    } else {
                                        
                                        nutrients = item.nutrition
                                        
                                        loadnutrientlabelsnoservings()
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
                
                defaultnutrientvalues()
                
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
                                        unitofmeasure = serving.unit!
                                        
                                        unitofmeasure = unitofmeasure.components(separatedBy: " ").dropFirst().joined(separator: " ")
                                        
                                        tapservingsize.setTitle("\(selectedservings) \(unitofmeasure)", for: .normal)

                                        if serving.servingWeight != nil {
                                            
                                            thisisit = serving.servingWeight!

                                            nutrients = item.nutrition
                                            
                                            loadnutrientlabelswithservings()
                                            
                                            
                                            
                                        
                                        } else {
                                            
                                            nutrients = item.nutrition
                                            
                                            loadnutrientlabelsnoservings()
                                            
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
                
                newsatfat = String(format: "%.1f", Double(newsatfat)! * Double(selectedservings)!)

                newcholesterol = String(format: "%.1f", Double(newcholesterol)! * Double(selectedservings)!)

                newsodium = String(format: "%.1f", Double(newsodium)! * Double(selectedservings)!)

                calories.text = newcalories
                totalfat.text = "\(newfats)g"
                satfat.text = "\(newsatfat)g"
                cholesterol.text = "\(newcholesterol)g"
                sodium.text = "\(newsodium)g"
                totalcarbs.text = "\(newcarbs)g"
                protein.text = "\(newprotein)g"

            }
    
    func defaultnutrientvalues() {
        
        newcalories = "0"
        newprotein = "0"
        newcarbs = "0"
        newfats = "0"
        newpotassium = "0"
        newsodium = "0"
        newcholesterol = "0"
        newzinc = "0"
        newfiber = "0"
        newvitaminD = "0"
        newseleneium = "0"
        newiron = "0"
        newcalcium = "0"
        newsatfat = "0"
        newsodium = "0"
        newsugars = "0"
        newvitamina = "0"
    }
            
            func storenewnutrientvalues() {
                
                var newcaloriess = Double(todayscalories)! + Double(newcalories)!
                var new1 = Double(oldfat)! + Double(newfats)!
                var new2 = Double(oldsatfat)! + Double(newsatfat)!
                var new3 = Double(oldcholesterol)! + Double(newcholesterol)!
                var new4 = Double(oldsodium)! + Double(newsodium)!
                var new5 = Double(oldcarbs)! + Double(newcarbs)!
                var new6 = Double(oldprotein)! + Double(newprotein)!

                
                ref?.child("OurUsers").child(uid).child(todaysdate).updateChildValues(["Calories" : String(newcaloriess), "Fat" : String(new1), "SatFat" : String(new2), "Cholesterol" : String(new3), "Sodium" : String(new4), "Carbs" : String(new5), "Protein" : String(new6)])
                
                
                DispatchQueue.main.async {
                    
                    self.performSegue(withIdentifier: "PostToHome", sender: self)
                    
                }
            }

var thisisit = Double()
    func loadnutrientlabelswithservings() {
        
        if nutrients["totalCarbs"] != nil {
            
            var intcarbs = nutrients["totalCarbs"]! * thisisit
            newcarbs = String(format: "%.1f", intcarbs * 1000)
            
        }
        if nutrients["protein"] != nil {
            
            var intprotein = nutrients["protein"]! * thisisit
            newprotein = String(format: "%.1f", intprotein * 1000)
            
        }
        
        if nutrients["calcium"] != nil {
            
            var intcalcium = nutrients["calcium"]! * thisisit
            newcalcium = String(format: "%.1f", intcalcium * 1000)
            
        }
        
        if nutrients["saturedFat"] != nil {
            
            var intsatfat = nutrients["saturedFat"]! * thisisit
            newsatfat = String(format: "%.1f", intsatfat * 1000)
            
        }
        
        if nutrients["sodium"] != nil {
            
            var intsodium = nutrients["sodium"]! * thisisit
            newsodium = String(format: "%.1f", intsodium * 1000)
            
        }
        
        if nutrients["cholesterol"] != nil {
            
            var intchol = nutrients["cholesterol"]! * thisisit
            newcholesterol = String(format: "%.1f", intchol * 1000)
            
        }
        
        if nutrients["vitaminA"] != nil {
            
            var inta = nutrients["vitaminA"]! * thisisit
            newvitamina = String(format: "%.1f", inta * 1000)
            
        }
        
        if nutrients["iron"] != nil {
            
            var intiron = nutrients["iron"]! * thisisit
            newiron = String(format: "%.1f", intiron * 1000)
            
        }
        
        
        if nutrients["sugars"] != nil {
            
            var intsugar = nutrients["sugars"]! * thisisit
            newsugars = String(format: "%.1f", intsugar * 1000)
            
        }
        
        if nutrients["potassium"] != nil {
            
            var intpotass = nutrients["potassium"]! * thisisit
            newpotassium = String(format: "%.1f", intpotass * 1000)
            
        }
        
        if nutrients["dietaryFiber"] != nil {
            
            var intfiber = nutrients["dietaryFiber"]! * thisisit
            newfiber = String(format: "%.1f", intfiber * 1000)
            
        }
        
        if nutrients["calories"] != nil {
            
            var intcalories = nutrients["calories"]! * thisisit
            newcalories = String(format: "%.1f", intcalories)
            
        }
        
        if nutrients["totalFat"] != nil {
            
            var intfat = nutrients["totalFat"]! * thisisit
            newfats = String(format: "%.1f", intfat * 1000)
            
        }
        
        multiplynutrition()

    }
    
    func loadnutrientlabelsnoservings() {
        
        if nutrients["totalCarbs"] != nil {
            
            var intcarbs = nutrients["totalCarbs"]!
            newcarbs = String(format: "%.1f", intcarbs * 1000)
            
        }
        if nutrients["protein"] != nil {
            
            var intprotein = nutrients["protein"]!
            newprotein = String(format: "%.1f", intprotein * 1000)
            
        }
        
        if nutrients["calcium"] != nil {
            
            var intcalcium = nutrients["calcium"]!
            newcalcium = String(format: "%.1f", intcalcium * 1000)
            
        }
        
        if nutrients["saturedFat"] != nil {
            
            var intsatfat = nutrients["saturedFat"]!
            newsatfat = String(format: "%.1f", intsatfat * 1000)
            
        }
        
        if nutrients["sodium"] != nil {
            
            var intsodium = nutrients["sodium"]!
            newsodium = String(format: "%.1f", intsodium * 1000)
            
        }
        
        if nutrients["cholesterol"] != nil {
            
            var intchol = nutrients["cholesterol"]!
            newcholesterol = String(format: "%.1f", intchol * 1000)
            
        }
        
        if nutrients["vitaminA"] != nil {
            
            var inta = nutrients["vitaminA"]!
            newvitamina = String(format: "%.1f", inta * 1000)
            
        }
        
        if nutrients["iron"] != nil {
            
            var intiron = nutrients["iron"]!
            newiron = String(format: "%.1f", intiron * 1000)
            
        }
        
        
        if nutrients["sugars"] != nil {
            
            var intsugar = nutrients["sugars"]!
            newsugars = String(format: "%.1f", intsugar * 1000)
            
        }
        
        if nutrients["potassium"] != nil {
            
            var intpotass = nutrients["potassium"]!
            newpotassium = String(format: "%.1f", intpotass * 1000)
            
        }
        
        if nutrients["dietaryFiber"] != nil {
            
            var intfiber = nutrients["dietaryFiber"]!
            newfiber = String(format: "%.1f", intfiber * 1000)
            
        }
        
        if nutrients["calories"] != nil {
            
            var intcalories = nutrients["calories"]!
            newcalories = String(format: "%.1f", intcalories)
            
        }
        
        if nutrients["totalFat"] != nil {
            
            var intfat = nutrients["totalFat"]!
            newfats = String(format: "%.1f", intfat * 1000)
            
        }
        
        multiplynutrition()

        
    }
    
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
            
        }


    

