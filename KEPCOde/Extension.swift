//
//  Extension.swift
//  KEPCOde
//
//  Created by 이지현 on 2018. 8. 25..
//  Copyright © 2018년 박세은. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func makeShadow(_ view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        view.layer.shadowRadius = 5
    }
}
