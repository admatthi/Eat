//
//  WorkoutTableViewCell.swift
//  Eat
//
//  Created by Alek Matthiessen on 6/17/18.
//  Copyright © 2018 AA Tech. All rights reserved.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {

    @IBOutlet weak var rest: UILabel!
    @IBOutlet weak var setsreps: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var photo2: UIImageView!
    @IBOutlet weak var photo1: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
