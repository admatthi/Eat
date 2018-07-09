//
//  ActivitiesTableViewCell.swift
//  Eat
//
//  Created by Alek Matthiessen on 7/5/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

class ActivitiesTableViewCell: UITableViewCell {

    @IBOutlet weak var tagimage: UIImageView!
    @IBOutlet weak var seperator: UILabel!
    @IBOutlet weak var activitylabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
