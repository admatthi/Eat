//
//  BookOverviewViewController.swift
//  Eat
//
//  Created by Alek Matthiessen on 7/12/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

class BookOverviewViewController: UIViewController {

    @IBAction func tapStartReading(_ sender: Any) {
        
        if purchased {
            
                self.performSegue(withIdentifier: "BookOverviewToRead", sender: self)
            
        } else {
            
            self.performSegue(withIdentifier: "BookOverviewToPurchase", sender: self)
        }
        
    }
    
    @IBOutlet weak var descriptionlabel: UILabel!
    @IBOutlet weak var tapstartreading: UIButton!
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var author: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        titlelabel.text = selectedtitle
        author.text = selectedauthor
        cover.image = selectedimage
        descriptionlabel.text = selecteddescription
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
