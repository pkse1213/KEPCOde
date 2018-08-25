//
//  CustomerLoginVC.swift
//  KEPCOde
//
//  Created by 박세은 on 2018. 8. 24..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class CustomerLoginVC: UIViewController,UITextFieldDelegate {

    let ud = UserDefaults.standard
    
    @IBOutlet weak var uidTxfd: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextView()
    }
    
    private func setupTextView() {
        uidTxfd.delegate = self
       
        let tapDidsmiss = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapDidsmiss)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        ud.setValue(uidTxfd.text!, forKey: "uid")
        let destvc = UIStoryboard(name: "CustomerMainTab", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarC") as! MainTabBarC
        //destvc.hero.tabBarAnimationType = .zoom
        self.present(destvc, animated: false, completion: nil)
    }
    @objc func dismissKeyboard() {
        uidTxfd.resignFirstResponder()
    }
    
    
    @objc func keyboardWillShow(_ sender: Notification) {
        if let keyboardFrame: NSValue = sender.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.origin.y = -keyboardHeight
        }
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
       
    }
}
