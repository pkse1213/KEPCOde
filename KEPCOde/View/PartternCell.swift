//
//  PartternCell.swift
//  KEPCOde
//
//  Created by 박세은 on 2018. 8. 25..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class PartternCell: UICollectionViewCell {
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        leftView.layer.cornerRadius = 5.5
        leftView.layer.masksToBounds = true
        rightView.layer.cornerRadius = 5.5
        rightView.layer.masksToBounds = true
    }
}
