//
//  HomeViewController.swift
//  TakeItLogin
//
//  Created by Mutyumu on 2021/3/3.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    
    var loginHandle: AuthStateDidChangeListenerHandle?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func checkStatus(_ sender: Any) {
        
        
        if UserDefaults.standard.string(forKey: "user_google_login") == "1" || UserDefaults.standard.string(forKey: "user_facebook_login") == "1" || UserDefaults.standard.string(forKey: "user_email_login") == "1"{
                // send them to a new view controller or do whatever you want
            
            performSegue(withIdentifier: "Member", sender: nil)
            }
        else{
            performSegue(withIdentifier: "NeedToLogIn", sender: nil)
        }
    }
    
    
    @IBAction func unwindToHome(_ unwindSegue: UIStoryboardSegue) {
        _ = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    
    
}
