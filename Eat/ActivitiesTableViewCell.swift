//
//  ActivitiesTableViewCell.swift
//  Eat
//
//  Created by Alek Matthiessen on 7/5/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

class ActivitiesTableViewCell: UITableViewCell {

    @IBOutlet weak var tagg: UIImageView!
    @IBOutlet weak var activitylabel: UILabel!
    @IBOutlet weak var check: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
