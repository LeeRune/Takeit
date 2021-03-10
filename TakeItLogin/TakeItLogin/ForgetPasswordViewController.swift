//
//  ForgetPasswordViewController.swift
//  TakeItLogin
//
//  Created by Mutyumu on 2021/3/3.
//

import UIKit
import Firebase

class ForgetPasswordViewController: UIViewController {

    @IBOutlet weak var emailTestField: UITextField!
    @IBOutlet weak var back: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        customemailTestField()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func resetPassword(_ sender: Any) {
        
        if emailTestField.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            let alert = UIAlertController(title: "錯誤", message: "請輸入電子信箱重設密碼", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        let auth = Auth.auth()
        
        auth.sendPasswordReset(withEmail: emailTestField.text!.trimmingCharacters(in: .whitespacesAndNewlines)) { (error) in
            if let error = error {
                
                let alert = UIAlertController(title: "錯誤", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
                
            }
            
            let alert = UIAlertController(title: "成功", message: "請到電子信箱重設密碼", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    func customemailTestField() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: emailTestField.frame.height-2, width: emailTestField.frame.width, height: 1)
        
        bottomLine.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        
        emailTestField.borderStyle = .none
        emailTestField.textColor = .white
        emailTestField.attributedPlaceholder = NSAttributedString(string: "電子信箱", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)])
        emailTestField.layer.addSublayer(bottomLine)
    }
}
