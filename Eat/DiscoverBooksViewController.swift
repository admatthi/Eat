//
//  DiscoverBooksViewController.swift
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

var bookids = [String]()
var booknames = [String:String]()
var bookauthors = [String:String]()
var bookcovers = [String:UIImage]()
var bookdescriptions = [String:String]()

var businessmoneybookids = [String]()
var businessmoneybooknames = [String:String]()
var businessmoneybookauthors = [String:String]()
var businessmoneybookcovers = [String:UIImage]()
var businessmoneydescriptions = [String:String]()

var healthbookids = [String]()
var healthbooknames = [String:String]()
var healthbookauthors = [String:String]()
var healthbookcovers = [String:UIImage]()
var healthdescriptions = [String:String]()

var socialbookids = [String]()
var socialbooknames = [String:String]()
var socialbookauthors = [String:String]()
var socialbookcovers = [String:UIImage]()
var socialdescriptions = [String:String]()

var purchased = Bool()

var selectedauthor = String()
var selectedimage = UIImage()
var selecteddescription = String()

class DiscoverBooksViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var loadinglabel: UILabel!
    @IBOutlet weak var loadinglabeltext: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionView4: UICollectionView!
    @IBOutlet weak var collectionView3: UICollectionView!
    @IBOutlet weak var authorofquote: UILabel!
    func hideloading() {
        
        authorofquote.alpha = 0
//        logo.alpha = 0
        loadinglabel.alpha = 0
        loadinglabeltext.alpha = 0
        activityIndicator.stopAnimating()
        activityIndicator.alpha = 0
    }
    
    func showloading() {
        
        authorofquote.alpha = 1
        logo.alpha = 1
        loadinglabel.alpha = 1
        loadinglabeltext.alpha = 1
        activityIndicator.startAnimating()
        activityIndicator.alpha = 1
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        
        self.becomeFirstResponder() // To get shake gesture
        
        tryingtopurchase = false
        // Do any additional setup after loading the view.
        
        showloading()
        
        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in

            
            if bookids.count == 0 {
                
                queryforbookids { () -> () in
                    
                    self.queryforbookinfo()
                    
                }
                
            } else {
                
                
            }
            
            
            backgroundlabel.layer.cornerRadius = 20.0
            backgroundlabel.clipsToBounds = true
            
            purchased = false
            tapsettings.alpha = 0
            
        } else {
            
            newuser = false
            // Do any additional setup after loading the view.
            
//            let date = Date()
//            let calendar = Calendar.current
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "MM-dd-yy"
//            todaysdate =  dateFormatter.string(from: date)
            
            backgroundlabel.layer.cornerRadius = 5.0
            backgroundlabel.clipsToBounds = true
            uid = (Auth.auth().currentUser?.uid)!
            
            if bookids.count == 0 {
                
            queryforbookids { () -> () in

                self.queryforbookinfo()

                }

            } else {
                
                
            }
            
            
            collectionView.reloadData()
            collectionView2.reloadData()
            collectionView3.reloadData()
            collectionView4.reloadData()
            
            purchased = true
            tapsettings.alpha = 1
        }
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var backgroundlabel: UILabel!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var tapsettings: UIButton!
    func queryforbookids(completed: @escaping (() -> ()) ) {
        
        var functioncounter = 0
        
        bookids.removeAll()
        bookcovers.removeAll()
        bookauthors.removeAll()
        booknames.removeAll()
        bookdescriptions.removeAll()
        
        businessmoneybookids.removeAll()
        businessmoneybookcovers.removeAll()
        businessmoneybookauthors.removeAll()
        businessmoneybooknames.removeAll()
        businessmoneydescriptions.removeAll()
        
        healthbookids.removeAll()
        healthbookcovers.removeAll()
        healthbookauthors.removeAll()
        healthbooknames.removeAll()
        healthdescriptions.removeAll()
        
        socialbookids.removeAll()
        socialbookcovers.removeAll()
        socialbookauthors.removeAll()
        socialbooknames.removeAll()
        socialdescriptions.removeAll()
        
        
        ref?.child("AllBooks").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for each in snapDict {
                    
                    let ids = each.key
                    
                    bookids.append(ids)
                    
                    functioncounter += 1
                    
                    if functioncounter == snapDict.count {
                        
                        completed()
                        
                    }
                    
                    
                }
                
            }
            
        })
        
        
    }
        func queryforbookinfo() {
            
            var functioncounter = 0
            
            for each in bookids  {
                
                ref?.child("AllBooks").child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    var value = snapshot.value as? NSDictionary
                    
                    
                    if var activityvalue = value?["Genre"] as? String {
                        
                        if activityvalue == "Business & Money" {
                            
                            businessmoneybookids.append(each)
                            
                            if var activityvalue = value?["Author"] as? String {
                                
                                businessmoneybookauthors[each] = activityvalue
                                
                            }
                            
                            
                            if var activityvalue2 = value?["Name"] as? String {
                                
                                businessmoneybooknames[each] = activityvalue2
                            }
                            
                            
                            if var activityvalue2 = value?["Description"] as? String {
                                
                                businessmoneydescriptions[each] = activityvalue2
                            }
                            
                            if var productimagee = value?["Image"] as? String {
                                
                                if productimagee.hasPrefix("http://") || productimagee.hasPrefix("https://") {
                                    
                                    let url = URL(string: productimagee)
                                    
                                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                                    
                                    if data != nil {
                                        
                                        let productphoto = UIImage(data: (data)!)
                                        
                                        //                            matchimages[each] = self.maskRoundedImage(image: productphoto!, radius: 180.0)
                                        let sizee = CGSize(width: 50, height: 50) // CGFloat, Double, Int
                                        
                                        businessmoneybookcovers[each] = productphoto
                                        
                                        functioncounter += 1
                                        
                                        
                                    }
                                    
                                    
                                }
                            }
                            
                        } else {
                            
                            if activityvalue == "Health, Fitness, & Dieting" {
                                
                                healthbookids.append(each)
                                if var activityvalue = value?["Author"] as? String {
                                    
                                    healthbookauthors[each] = activityvalue
                                    
                                }
                                
                                
                                if var activityvalue2 = value?["Name"] as? String {
                                    
                                    healthbooknames[each] = activityvalue2
                                }
                                
                                
                                if var activityvalue2 = value?["Description"] as? String {
                                    
                                    healthdescriptions[each] = activityvalue2
                                }
                                
                                if var productimagee = value?["Image"] as? String {
                                    
                                    if productimagee.hasPrefix("http://") || productimagee.hasPrefix("https://") {
                                        
                                        let url = URL(string: productimagee)
                                        
                                        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                                        
                                        if data != nil {
                                            
                                            let productphoto = UIImage(data: (data)!)
                                            
                                            //                            matchimages[each] = self.maskRoundedImage(image: productphoto!, radius: 180.0)
                                            let sizee = CGSize(width: 50, height: 50) // CGFloat, Double, Int
                                            
                                            healthbookcovers[each] = productphoto
                                            
                                            functioncounter += 1
                                            
                                            
                                        }
                                        
                                        
                                    }
                                }
                                
                            } else {
                                
                                if activityvalue == "Politics & Social Science" {
                                    
                                    socialbookids.append(each)
                                    if var activityvalue = value?["Author"] as? String {
                                        
                                        socialbookauthors[each] = activityvalue
                                        
                                    }
                                    
                                    
                                    if var activityvalue2 = value?["Name"] as? String {
                                        
                                        socialbooknames[each] = activityvalue2
                                    }
                                    
                                    
                                    if var activityvalue2 = value?["Description"] as? String {
                                        
                                        socialdescriptions[each] = activityvalue2
                                    }
                                    
                                    if var productimagee = value?["Image"] as? String {
                                        
                                        if productimagee.hasPrefix("http://") || productimagee.hasPrefix("https://") {
                                            
                                            let url = URL(string: productimagee)
                                            
                                            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                                            
                                            if data != nil {
                                                
                                                let productphoto = UIImage(data: (data)!)
                                                
                                                //                            matchimages[each] = self.maskRoundedImage(image: productphoto!, radius: 180.0)
                                                let sizee = CGSize(width: 50, height: 50) // CGFloat, Double, Int
                                                
                                                socialbookcovers[each] = productphoto
                                                
                                                functioncounter += 1
                                                
                                                
                                            }
                                            
                                            
                                        }
                                    }
                                }
                            }
                        }
                        
                    }
                    
//                    self.collectionView4.reloadData()
//                    self.collectionView3.reloadData()
//                    self.collectionView2.reloadData()
//                    self.collectionView.reloadData()
                    
                    if functioncounter == bookids.count {
//
                        booknames.update(other: healthbooknames)
                        booknames.update(other: socialbooknames)
                        booknames.update(other: businessmoneybooknames)

                        bookauthors.update(other: healthbookauthors)
                        bookauthors.update(other: socialbookauthors)
                        bookauthors.update(other: businessmoneybookauthors)

                        bookcovers.update(other: healthbookcovers)
                        bookcovers.update(other: businessmoneybookcovers)
                        bookcovers.update(other: socialbookcovers)
                        
                        bookdescriptions.update(other: socialdescriptions)
                            bookdescriptions.update(other: healthdescriptions)
                        bookdescriptions.update(other: businessmoneydescriptions)
                    
                        
                        self.collectionView4.reloadData()
                        self.collectionView3.reloadData()
                        self.collectionView2.reloadData()
                        self.collectionView.reloadData()
                        
                    }
                })
                
            }
            
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 1 {
        
        if businessmoneybooknames.count > 0 {
            
            return businessmoneybooknames.count
            
        } else {
            
           return 1
            
        }
        
        } else {
            
            if collectionView.tag == 2 {
                
                if healthbooknames.count > 0 {
                    
                    return healthbooknames.count
                    
                } else {
                    
                    return 1
                }
                
            } else {
                
                if collectionView.tag == 3 {
                    
                    if socialbooknames.count > 0 {
                        
                        return socialbooknames.count
                        
                    } else {
                        
                        return 1
                    }
                    
                } else {
                    
                    if collectionView.tag == 4 {
                        
                        if booknames.count > 0 {
                            
                            return booknames.count
                            
                        } else {
                            
                            return 1
                        }
                        
                    } else {
                        
                        return 1
                    }
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Books", for: indexPath) as! BooksCollectionViewCell
        cell.bookcover.layer.cornerRadius = 10.0
        cell.bookcover.layer.masksToBounds = true
        
        cell.dark.layer.cornerRadius = 10.0
        cell.dark.layer.masksToBounds = true
        
        
        if collectionView.tag == 4 {
        if bookauthors.count > indexPath.row {
            
        cell.bookauthor.text = bookauthors[bookids[indexPath.row]]
        cell.bookcover.image = bookcovers[bookids[indexPath.row]]
        cell.booktitle.text = booknames[bookids[indexPath.row]]

            
        hideloading()
            
        }
        
        }
        
        if collectionView.tag == 1 {
            if businessmoneybookauthors.count > indexPath.row {
                
                cell.bookauthor.text = businessmoneybookauthors[businessmoneybookids[indexPath.row]]
                cell.bookcover.image = businessmoneybookcovers[businessmoneybookids[indexPath.row]]
                cell.booktitle.text = businessmoneybooknames[businessmoneybookids[indexPath.row]]
 
                
                hideloading()
                
            }
            
        }
        
        if collectionView.tag == 2 {
            if healthbookauthors.count > indexPath.row {
                
                cell.bookauthor.text = healthbookauthors[healthbookids[indexPath.row]]
                cell.bookcover.image = healthbookcovers[healthbookids[indexPath.row]]
                cell.booktitle.text = healthbooknames[healthbookids[indexPath.row]]

                
                hideloading()
                
            }
            
        }
        
        if collectionView.tag == 3 {
            
            if socialbookauthors.count > indexPath.row {
                
                cell.bookauthor.text = socialbookauthors[socialbookids[indexPath.row]]
                cell.bookcover.image = socialbookcovers[socialbookids[indexPath.row]]
                cell.booktitle.text = socialbooknames[socialbookids[indexPath.row]]

                
                hideloading()
                
            }
            
        }
  
        return cell
    }
    
    @IBOutlet weak var collectionView2: UICollectionView!
    @IBOutlet weak var whitelabel: UILabel!
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView.tag == 1 {
            
                selectedbookid = businessmoneybookids[indexPath.row]
                selectedtitle = businessmoneybooknames[businessmoneybookids[indexPath.row]]!
            
            selectedauthor = businessmoneybookauthors[businessmoneybookids[indexPath.row]]!
            selectedimage = businessmoneybookcovers[businessmoneybookids[indexPath.row]]!

            selecteddescription = businessmoneydescriptions[businessmoneybookids[indexPath.row]]!
            
            if purchased {
                
                self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                
            } else {
                
                self.performSegue(withIdentifier: "HomeToPurchase", sender: self)
                
            }
            
            
        } else {
            
            
            if collectionView.tag == 2 {
                
                selectedbookid = healthbookids[indexPath.row]
                selectedtitle = healthbooknames[healthbookids[indexPath.row]]!
                selectedauthor = healthbookauthors[healthbookids[indexPath.row]]!
                selectedimage = healthbookcovers[healthbookids[indexPath.row]]!
                selecteddescription = healthdescriptions[healthbookids[indexPath.row]]!
                if purchased {
                    
                    self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                    
                } else {
                    
                    self.performSegue(withIdentifier: "HomeToPurchase", sender: self)
                    
                }
                
            } else {
                
                if collectionView.tag == 3 {
                    
                    selectedbookid = socialbookids[indexPath.row]
                    selectedtitle = socialbooknames[socialbookids[indexPath.row]]!
                    selectedauthor = socialbookauthors[socialbookids[indexPath.row]]!
                    selectedimage = socialbookcovers[socialbookids[indexPath.row]]!
                    selecteddescription = socialdescriptions[socialbookids[indexPath.row]]!
                    if purchased {
                        
                        self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                        
                    } else {
                        
                        self.performSegue(withIdentifier: "HomeToPurchase", sender: self)
                        
                    }
                    
                } else {
                    
                    if collectionView.tag == 4 {
                        
                        selectedbookid = bookids[indexPath.row]
                        selectedtitle = booknames[bookids[indexPath.row]]!
                        selectedauthor = bookauthors[bookids[indexPath.row]]!
                        selectedimage = bookcovers[bookids[indexPath.row]]!
                        selecteddescription = businessmoneydescriptions[bookids[indexPath.row]]!
                        
                        if purchased {
                            
                            self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)

                        } else {
                            
                            self.performSegue(withIdentifier: "HomeToPurchase", sender: self)

                        }
                        
                    }
                }
            }
            
        }

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

extension Dictionary {
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}
