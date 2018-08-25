//
//  MyPageVC.swift
//  KEPCOde
//
//  Created by 박세은 on 2018. 8. 25..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class MyPageVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var uidLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    
    
    @IBOutlet weak var pointTableView: UITableView!
    
    var dayArr:[String] = []
    var pointArr:[Int] = [] {
        didSet {
            pointTableView.reloadData()
        }
    }
    
    
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pointTableView.delegate = self
        pointTableView.dataSource = self
        
        uidLabel.text = ud.value(forKey: "uid") as? String
        dateInit()
        makeShadow(view1)
        makeShadow(view2)
        makeShadow(view3)
        makeShadow(view4)
    }
    
    func dateInit(){
        let currentDateTime = Date()
       let userCalendar = Calendar.current
        let requestedComponents: Set<Calendar.Component> = [
           .month,
            .day,
           
        ]
        let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
        guard let day = dateTimeComponents.day else {return}
        guard let month = dateTimeComponents.month else {return}
        
        for i in 1...20 {
            
            if day - i <= 0 {
                dayArr.append("\(month-1)" + "." + "\(day - i+31)")
                pointArr.append((day+31)*(Int(arc4random_uniform(6))))
            } else {
                dayArr.append("\(month)" + "." + "\(day - i)")
                pointArr.append((day)*(Int(arc4random_uniform(12))))
                
            }
        }
        var a = 0
        for i in 0...pointArr.count-1 {
            a += pointArr[i]
        }
        pointLabel.text = "\(a)p"
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pointArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pointTableView.dequeueReusableCell(withIdentifier: "PointCell", for: indexPath) as! PointCell
       
        cell.dayLabel.text = dayArr[indexPath.row]
            
        cell.pointLabel.text = "\(pointArr[indexPath.row])" + "p"
        return cell
    }
    
}
