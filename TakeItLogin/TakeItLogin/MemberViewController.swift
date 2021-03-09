//
//  MemberViewController.swift
//  TakeItLogin
//
//  Created by Mutyumu on 2021/3/3.
//

import UIKit
import FirebaseAuth
import FacebookLogin
import Kingfisher
import FirebaseStorage

class MemberViewController: UIViewController {
    
    

    @IBOutlet weak var memberPic: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if  UserDefaults.standard.string(forKey: "user_google_login") == "1" || UserDefaults.standard.string(forKey: "user_facebook_login") == "1" {
            memberPic.kf.setImage(with: URL(string: UserDefaults.standard.object(forKey: "user_photo") as! String ))
        }
        
        else{
            
            let storageRef = Storage.storage().reference(forURL: "gs://takeit-7eb5d.appspot.com")
            let userUID = UserDefaults.standard.string(forKey: "user_uid_key")!
            let storageUserPhoto = storageRef.child("userPhoto").child(userUID)
            storageUserPhoto.downloadURL { (url, error) in
                if let photoUrl = url?.absoluteString{
                    UserDefaults.standard.set(photoUrl, forKey: "user_photo")
                    self.memberPic.kf.setImage(with: URL(string: UserDefaults.standard.string(forKey: "user_photo")!))
                }
            }
        }
    }
    
    @IBAction func logOut(_ sender: Any) {
        do {
            UserDefaults.standard.set("0", forKey: "user_email_login")
            UserDefaults.standard.set("0", forKey: "user_google_login")
            UserDefaults.standard.set("0", forKey: "user_facebook_login")
            UserDefaults.standard.removeObject(forKey: "user_photo")
            try Auth.auth().signOut()
        } catch {
           print(error)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
