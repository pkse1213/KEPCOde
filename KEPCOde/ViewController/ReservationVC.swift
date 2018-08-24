//
//  ReservationVC.swift
//  KEPCOde
//
//  Created by 박세은 on 2018. 8. 24..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class ReservationVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var kwtextField: UITextField!
    @IBOutlet weak var moneyLabel: UILabel!
    
    var amount = 0
    
    @IBAction func exitAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.kwtextField.delegate = self
//        kwtextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        print("Dddddddsfs        dsfsdfdsfdsfsdfsd")
        var won = ""
        if textField.text == "" {
            won = "0"
        } else {
            let tmp = textField.text!.replacingOccurrences(of: ",", with: "")
            print(tmp)
            guard var kw = Int(tmp) else {return}
            kw = kw * 81
            amount = kw
            
            var a = Array(String(kw))
            a = a.reversed()
            
            var b :[Character] = []
            for i in 0...a.count-1 {
                b.append(a[i])
                if (i+1) % 3 == 0 &&  i != a.count-1{
                    b.append(",")
                }
            }
            b.reverse()
            
            for i in 0...b.count-1 {
                won += String(b[i])
            }
        }
        print(won)
        moneyLabel.text = won
        
    }
    
    @IBAction func reserveAction(_ sender: UIButton) {
        if kwtextField.text == "" {
            let alert = UIAlertController(title: "경고", message: "예상 전력량을 입력하세요.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "알림", message: "\(kwtextField.text!)kw를 예약하시겠습니까?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default) { (_) in
//                self.dismiss(animated: true, completion: nil)
            }
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        }
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        formatter.maximumFractionDigits = 0
        if let removeAllSeprator = textField.text?.replacingOccurrences(of: formatter.groupingSeparator, with: ""){ // ---- 1
            var beforeForemattedString = removeAllSeprator + string // --- 2
            if formatter.number(from: string) != nil { // --- 3
                if let formattedNumber = formatter.number(from: beforeForemattedString), let formattedString = formatter.string(from: formattedNumber){ // --- 4
                    textField.text = formattedString // --- 5
                    textFieldDidChange(textField)
                    
                    return false
                }
            }else{ // --- 6
                if string == "" { // --- 7
                    let lastIndex = beforeForemattedString.index(beforeForemattedString.endIndex, offsetBy: -1)
                    beforeForemattedString = String(beforeForemattedString[..<lastIndex])
                    if let formattedNumber = formatter.number(from: beforeForemattedString), let formattedString = formatter.string(from: formattedNumber){
                        textField.text = formattedString
                        
                        textFieldDidChange(textField)
                        return false
                    }
                }else{ // --- 8
                    textFieldDidChange(textField)
                    return false
                }
            }
        }
        textFieldDidChange(textField)
        
        return true
    }
}
