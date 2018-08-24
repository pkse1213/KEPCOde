//
//  PatternVC.swift
//  KEPCOde
//
//  Created by 박세은 on 2018. 8. 25..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class PatternVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var partternCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        partternCollectionView.delegate = self
        partternCollectionView.dataSource = self
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
        let cell = partternCollectionView.dequeueReusableCell(withReuseIdentifier: "PartternCell", for: indexPath) as! PartternCell
        return cell
    }
}
