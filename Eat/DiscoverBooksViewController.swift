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

var selfhelpbookids = [String]()
var selfhelpbooknames = [String:String]()
var selfhelpbookauthors = [String:String]()
var selfhelpbookcovers = [String:UIImage]()
var selfhelpdescriptions = [String:String]()

var selfhelp = Bool()

var purchased = Bool()

var selectedauthor = String()
var selectedimage = UIImage()
var selecteddescription = String()

class DiscoverBooksViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var loadinglabel: UILabel!
    @IBOutlet weak var loadinglabeltext: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var authorofquote: UILabel!
    func hideloading() {
        
        authorofquote.alpha = 0
        logo.alpha = 0
        loadinglabel.alpha = 0
        loadinglabeltext.alpha = 0
    }
    
    func showloading() {
        
        authorofquote.alpha = 1
        logo.alpha = 1
        loadinglabel.alpha = 1
        loadinglabeltext.alpha = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        
        self.becomeFirstResponder() // To get shake gesture
        
        tryingtopurchase = false
        // Do any additional setup after loading the view.
        
        showloading()
        
        if Auth.auth().currentUser == nil {
            // Do smth if user is not logged in
            
            whitelabel.layer.cornerRadius = 5.0
            whitelabel.layer.masksToBounds = true
            
            queryforbookids { () -> () in
                
                self.queryforbookinfo()
                
            }
            
            queryforselfhelpbookids { () -> () in
                
                self.queryforselfhelpbookinfo()
                
            }
            
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
            
            uid = (Auth.auth().currentUser?.uid)!
            
            queryforbookids { () -> () in

                self.queryforbookinfo()

            }
            
            queryforselfhelpbookids { () -> () in
                
                self.queryforselfhelpbookinfo()
                
            }
            
            
            collectionView.reloadData()
            collectionView2.reloadData()
            
            purchased = true
            tapsettings.alpha = 1
        }
        // Do any additional setup after loading the view.
    }

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
        
        ref?.child("Books").observeSingleEvent(of: .value, with: { (snapshot) in
            
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
                
                ref?.child("Books").child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    var value = snapshot.value as? NSDictionary
                    
                    if var activityvalue = value?["Author"] as? String {
                        
                        bookauthors[each] = activityvalue
                        
                    }
                    
                    
                    if var activityvalue2 = value?["Name"] as? String {
                        
                        booknames[each] = activityvalue2
                    }
                    
                    
                    if var activityvalue2 = value?["Description"] as? String {
                        
                        bookdescriptions[each] = activityvalue2
                    }
                    
                    if var productimagee = value?["Image"] as? String {
                        
                        if productimagee.hasPrefix("http://") || productimagee.hasPrefix("https://") {
                            
                            let url = URL(string: productimagee)
                            
                            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                            
                            if data != nil {
                                
                                let productphoto = UIImage(data: (data)!)
                                
                                //                            matchimages[each] = self.maskRoundedImage(image: productphoto!, radius: 180.0)
                                let sizee = CGSize(width: 50, height: 50) // CGFloat, Double, Int
                                
                                bookcovers[each] = productphoto
                                
                                functioncounter += 1
                                
                                
                            }
                            
                            
                        }
                    }
                    
                    if functioncounter == bookids.count {
                        
                        self.collectionView.reloadData()
                        
                    }
                })
                
            }
            
    }
    
    func queryforselfhelpbookids(completed: @escaping (() -> ()) ) {
        
        var functioncounter = 0
        
        selfhelpbookids.removeAll()
        selfhelpbookcovers.removeAll()
        selfhelpbookauthors.removeAll()
        selfhelpbooknames.removeAll()
        selfhelpdescriptions.removeAll()
        
        ref?.child("SelfHelpBooks").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for each in snapDict {
                    
                    let ids = each.key
                    
                    selfhelpbookids.append(ids)
                    
                    functioncounter += 1
                    
                    if functioncounter == snapDict.count {
                        
                        completed()
                        
                    }
                    
                    
                }
                
            }
            
        })
        
        
    }
    func queryforselfhelpbookinfo() {
        
        var functioncounter = 0
        
        for each in selfhelpbookids  {
            
            ref?.child("SelfHelpBooks").child(each).observeSingleEvent(of: .value, with: { (snapshot) in
                
                var value = snapshot.value as? NSDictionary
                
                if var activityvalue = value?["Author"] as? String {
                    
                    selfhelpbookauthors[each] = activityvalue
                    
                }
                
                
                if var activityvalue2 = value?["Name"] as? String {
                    
                    selfhelpbooknames[each] = activityvalue2
                }
                
                
                if var activityvalue2 = value?["Description"] as? String {
                    
                    selfhelpdescriptions[each] = activityvalue2
                }
                
                if var productimagee = value?["Image"] as? String {
                    
                    if productimagee.hasPrefix("http://") || productimagee.hasPrefix("https://") {
                        
                        let url = URL(string: productimagee)
                        
                        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                        
                        if data != nil {
                            
                            let productphoto = UIImage(data: (data)!)
                            
                            //                            matchimages[each] = self.maskRoundedImage(image: productphoto!, radius: 180.0)
                            let sizee = CGSize(width: 50, height: 50) // CGFloat, Double, Int
                            
                            selfhelpbookcovers[each] = productphoto
                            
                            functioncounter += 1
                            
                            
                        }
                        
                        
                    }
                }
                
                if functioncounter == selfhelpbookids.count {
                    
                    self.collectionView2.reloadData()
                    
                }
            })
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 1 {
        
        if bookids.count > 0 {
            
            return bookids.count
            
        } else {
            
           return 1
            
        }
        
        } else {
            
            if collectionView.tag == 2 {
                
                if selfhelpbookids.count > 0 {
                    
                    return selfhelpbookids.count
                    
                } else {
                    
                    return 1
                }
                
            } else {
                
                return 1
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Books", for: indexPath) as! BooksCollectionViewCell
        
        if collectionView.tag == 1 {
        if bookauthors.count > indexPath.row {
            
        cell.bookauthor.text = bookauthors[bookids[indexPath.row]]
        cell.bookcover.image = bookcovers[bookids[indexPath.row]]
        cell.booktitle.text = booknames[bookids[indexPath.row]]
        cell.bookcover.layer.cornerRadius = 5.0
        cell.bookcover.layer.masksToBounds = true
            
        hideloading()
            
        }
        
        }
        
        if collectionView.tag == 2 {
            if selfhelpbookauthors.count > indexPath.row {
                
                cell.bookauthor.text = selfhelpbookauthors[selfhelpbookids[indexPath.row]]
                cell.bookcover.image = selfhelpbookcovers[selfhelpbookids[indexPath.row]]
                cell.booktitle.text = selfhelpbooknames[selfhelpbookids[indexPath.row]]
                cell.bookcover.layer.cornerRadius = 5.0
                cell.bookcover.layer.masksToBounds = true
                
                hideloading()
                
            }
            
        }
  
        return cell
    }
    
    @IBOutlet weak var collectionView2: UICollectionView!
    @IBOutlet weak var whitelabel: UILabel!
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView.tag == 1 {
            
                selectedbookid = bookids[indexPath.row]
                selectedtitle = booknames[bookids[indexPath.row]]!
            
            selectedauthor = bookauthors[bookids[indexPath.row]]!
            selectedimage = bookcovers[bookids[indexPath.row]]!
                selfhelp = false

            selecteddescription = bookdescriptions[bookids[indexPath.row]]!
                self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
            
            
        } else {
            
            
            if collectionView.tag == 2 {
                
                selfhelp = true
                selectedbookid = selfhelpbookids[indexPath.row]
                selectedtitle = selfhelpbooknames[selfhelpbookids[indexPath.row]]!
                selectedauthor = selfhelpbookauthors[selfhelpbookids[indexPath.row]]!
                selectedimage = selfhelpbookcovers[selfhelpbookids[indexPath.row]]!
                selecteddescription = selfhelpdescriptions[selfhelpbookids[indexPath.row]]!
                self.performSegue(withIdentifier: "HomeToBookOverview", sender: self)
                
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
