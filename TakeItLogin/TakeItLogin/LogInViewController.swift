//
//  LogInViewController.swift
//  TakeItLogin
//
//  Created by Mutyumu on 2021/3/3.
//

import UIKit
import FirebaseAuth
import FacebookLogin
import GoogleSignIn
import FirebaseStorage

class LogInViewController: UIViewController, GIDSignInDelegate, UITextFieldDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("Google Sing In didSignInForUser")
      if let error = error {
        print(error.localizedDescription)
        return
      }
      guard let authentication = user.authentication else { return }
      let credential = GoogleAuthProvider.credential(withIDToken: (authentication.idToken)!, accessToken: (authentication.accessToken)!)
  // When user is signed in
      Auth.auth().signIn(with: credential, completion: { (user, error) in
        if error != nil {
            let alert = UIAlertController(title: "錯誤", message: "請再試一次", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
          return
        }
        else{
            
            let photoUrl1 = Auth.auth().currentUser!.photoURL!.absoluteString
            
            let photoUrl2 = photoUrl1.substring(toIndex: photoUrl1.length - 4)
            
            let photoUrl3 = photoUrl2 + "400-c"
            
            
            print(photoUrl3)
            UserDefaults.standard.set("1", forKey: "user_google_login")
            UserDefaults.standard.set(photoUrl3, forKey: "user_photo")
            self.performSegue(withIdentifier: "LogIn", sender: nil)
        }
      })
    }
    // Start Google OAuth2 Authentication
    func sign(_ signIn: GIDSignIn?, present viewController: UIViewController?) {
    
      // Showing OAuth2 authentication window
      if let aController = viewController {
        present(aController, animated: true) {() -> Void in }
      }
    }
    // After Google OAuth2 authentication
    func sign(_ signIn: GIDSignIn?, dismiss viewController: UIViewController?) {
      // Close OAuth2 authentication window
      dismiss(animated: true) {() -> Void in }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
      }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().clientID = "1021546538470-7fs71127m8qnnl6vaeitnjdste9b8cae.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
        email.delegate = self
        password.delegate = self
        customEmailTextField()
        customPasswordTextField()
    }
    
    @IBOutlet weak var googleLogIn: GIDSignInButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var facebookLogin: UIButton!
    
    @IBAction func logIn(_ sender: Any) {
        
        let emailText = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordText = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if emailText == "" || passwordText == "" {
            let alert = UIAlertController(title: "錯誤", message: "請輸入帳號密碼", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        
        // Signing in the user
        Auth.auth().signIn(withEmail: emailText, password: passwordText) { (result, error) in
            
            if error != nil {
                print("BB"+emailText+"AA")
                let alert = UIAlertController(title: "錯誤", message: "帳號或密碼錯誤", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else {
                
                UserDefaults.standard.set(Auth.auth().currentUser?.uid, forKey: "user_uid_key")
                UserDefaults.standard.set("1", forKey: "user_email_login")
                self.performSegue(withIdentifier: "LogIn", sender: nil)
            }
        }
    }
    
    @IBAction func forgetPassword(_ sender: Any) {
        
    }
    
    @IBAction func signIn(_ sender: Any) {
        
    }
   
    @IBAction func googleLogIn(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func facebookLogIn(_ sender: Any) {
        let manager = LoginManager()
        manager.logIn(permissions: [.publicProfile], viewController: self) { (result) in
            if case LoginResult.success(granted: _, declined: _, token: _) = result {
                ApplicationDelegate.initializeSDK(nil)
                let credential =  FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
                Auth.auth().signIn(with: credential) { (result, error) in
                    if error != nil {
                        let alert = UIAlertController(title: "錯誤", message: "請再試一次", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    else {
                    
                        UserDefaults.standard.set("1", forKey: "user_facebook_login")
                        
                        if let user = Auth.auth().currentUser {
                            print("\(user.providerID) login")
                            if user.providerData.count > 0 {
                                let userInfo = user.providerData[0]
                                print(userInfo.providerID, userInfo.displayName!, userInfo.photoURL!)
                                let photoUrl = userInfo.photoURL!.absoluteString + "?height=400&access_token=\(AccessToken.current!.tokenString)"
                                UserDefaults.standard.set(photoUrl, forKey: "user_photo")
                                
                            }
                        }
                        
                        self.performSegue(withIdentifier: "LogIn", sender: nil)
                    }
                }
            }
        }
    }
    
    
    func customEmailTextField() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: email.frame.height-2, width: email.frame.width, height: 1)
        
        bottomLine.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        
        email.borderStyle = .none
        email.textColor = .white
        email.attributedPlaceholder = NSAttributedString(string: "電子信箱", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)])
        email.layer.addSublayer(bottomLine)
    }
    
    func customPasswordTextField() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: password.frame.height-2, width: password.frame.width, height: 1)
        
        bottomLine.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        
        password.borderStyle = .none
        password.textColor = .white
        password.attributedPlaceholder = NSAttributedString(string: "輸入密碼", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)])
        password.layer.addSublayer(bottomLine)
    }
    
    @IBAction func unwindToPageC(_ unwindSegue: UIStoryboardSegue) {
            print("unwindToPageC...")
        }
    
}

extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}


