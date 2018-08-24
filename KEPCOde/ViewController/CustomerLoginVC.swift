//
//  CustomerLoginVC.swift
//  KEPCOde
//
//  Created by 박세은 on 2018. 8. 24..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class CustomerLoginVC: UIViewController {

    let ud = UserDefaults.standard
    
    @IBOutlet weak var uidTxfd: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        ud.setValue(uidTxfd.text!, forKey: "uid")
        let destvc = UIStoryboard(name: "CustomerMainTab", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarC") as! MainTabBarC
        //destvc.hero.tabBarAnimationType = .zoom
        self.present(destvc, animated: false, completion: nil)
    }
    

}
