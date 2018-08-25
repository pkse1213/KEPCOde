//
//  PatternVC.swift
//  KEPCOde
//
//  Created by 박세은 on 2018. 8. 25..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class PatternVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var partternCollectionView: UICollectionView!
    @IBOutlet weak var pattern2CollectionView: UICollectionView!
    
    
    let dayArr = ["월", "화", "수", "목", "금", "토", "일"]
    override func viewDidLoad() {
        super.viewDidLoad()
        makeShadow(view1)
        makeShadow(view2)
        partternCollectionView.delegate = self
        partternCollectionView.dataSource = self
        pattern2CollectionView.delegate = self
        pattern2CollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == partternCollectionView {
            
            let cell = partternCollectionView.dequeueReusableCell(withReuseIdentifier: "PartternCell", for: indexPath) as! PartternCell
            cell.dayLabel.text = dayArr[indexPath.item]
            var number = Int(arc4random_uniform(55))
            cell.leftView.center.y += CGFloat(number)
            number = Int(arc4random_uniform(55))
            cell.rightView.center.y += CGFloat(number)
            return cell
        } else {
            
            let cell = pattern2CollectionView.dequeueReusableCell(withReuseIdentifier: "PartternCell2", for: indexPath) as! PartternCell
            cell.dayLabel.text = dayArr[indexPath.item]
            var number = Int(arc4random_uniform(55))
            cell.leftView.center.y += CGFloat(number)
            number = Int(arc4random_uniform(55))
            cell.rightView.center.y += CGFloat(number)
            return cell
        }
        
        
    }
}
