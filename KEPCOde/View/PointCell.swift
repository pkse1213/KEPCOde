//
//  PointCell.swift
//  KEPCOde
//
//  Created by 박세은 on 2018. 8. 25..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class PointCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
