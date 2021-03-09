//
//  SignInViewController.swift
//  TakeItLogin
//
//  Created by Mutyumu on 2021/3/3.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage


class SignUpViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        password.delegate = self
        email.delegate = self
        confirmPassword.delegate = self
        customEmailTestField()
        customPasswordTestField()
        customConfirmPasswordTestField()
        userUploadImage.image = UIImage(named: "persona")

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var userUploadImage: UIImageView!

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
      }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func signUp(_ sender: Any) {
        // Validate the fields
        let error = validateFields()
        if error == false {
            
            // There's something wrong with the fields, show error message
            print("Error in textfields")
            let alert = UIAlertController(title: "錯誤", message: "電子信箱格式不符", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        else {
            
            // Create cleaned versions of the data
            let emailText = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let passwordText = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the user

            Auth.auth().createUser(withEmail: emailText, password: passwordText) { (result, err) in
                
                // Check for errors
                if err != nil {
                    
                    // There was an error creating the user
                    print("Error creating user")
                }
                else{
                    
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["uid": result!.user.uid, "email": emailText]) { (error) in
                        
                        if error != nil {
                            // Show error message
                            print("Error saving user data")
                        }
                    }
                    
                    let storageRef = Storage.storage().reference(forURL: "gs://takeit-7eb5d.appspot.com")
                    let storageUserPhoto = storageRef.child("userPhoto").child(result!.user.uid)
                    
                    let metadata = StorageMetadata()
                    metadata.contentType = "image/jpg"
                    
                    let userPhotoData = self.userUploadImage.image?.jpegData(compressionQuality: 0.5)
                    
                    storageUserPhoto.putData(userPhotoData!, metadata: metadata) { (StorageMetadata, error) in
                        if error != nil {
                            print("Error saving user photo")
                            return
                        }
                        
                        storageUserPhoto.downloadURL { (url, error) in
                            if let photoUrl = url?.absoluteString{
                                print(photoUrl)
                                UserDefaults.standard.set(photoUrl, forKey: "user_photo")
                            }
                        }
                    }
                    
                    
                    Auth.auth().signIn(withEmail: emailText, password: passwordText, completion: nil)
                    
                    UserDefaults.standard.set("1", forKey: "user_email_login")
                    UserDefaults.standard.set(Auth.auth().currentUser?.uid, forKey: "user_uid_key")
                    
                    let alert = UIAlertController(title: "註冊成功！", message: "歡迎加入Take It會員!", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                        
                        if UserDefaults.standard.object(forKey: "user_email_login") != nil {
                            self.performSegue(withIdentifier: "SignUpSuccess", sender: nil)
                        }
                        else{
                            print("Error")
                        }
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func userUploadImage(_ sender: Any) {
        let alert = UIAlertController(title: "選圖片", message: nil, preferredStyle: .actionSheet)
        
        
        alert.addAction(UIAlertAction(title: "從相機", style: .default, handler: { (UIAlertAction) in
            let controller = UIImagePickerController()
            controller.sourceType = .camera
            controller.delegate = self
            self.present(controller, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "從相簿", style: .default, handler: { (UIAlertAction) in
            let controller = UIImagePickerController()
            controller.sourceType = .photoLibrary
            controller.delegate = self
            self.present(controller, animated: true, completion: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        userUploadImage.image = image
        dismiss(animated: true, completion: nil)
    }
    
    func validateFields() -> Bool{
        
        // Check that all fields are filled in
        if
            email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                confirmPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            let alert = UIAlertController(title: "錯誤", message: "請填寫所有欄位", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return false
        }
        
        if password.text?.trimmingCharacters(in: .whitespacesAndNewlines) != confirmPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            let alert = UIAlertController(title: "錯誤", message: "兩個欄位密碼不相同", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return false
        }
        
        // Check if the password is secure
        let cleanedPassword = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            let alert = UIAlertController(title: "錯誤", message: "密碼至少八個字元，並且包含數字、英文及符號", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return false
        }
        
        if userUploadImage.image == UIImage(named: "persona"){
            let alert = UIAlertController(title: "錯誤", message: "請上傳一張照片", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return false
        }
        
        return true
    }
    
    func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    func customPasswordTestField() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: password.frame.height-2, width: password.frame.width, height: 1)
        
        bottomLine.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        
        password.borderStyle = .none
        password.textColor = .white
        password.attributedPlaceholder = NSAttributedString(string: "輸入密碼", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)])
        password.layer.addSublayer(bottomLine)
    }
    
    func customEmailTestField() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: password.frame.height-2, width: email.frame.width, height: 1)
        
        bottomLine.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        
        email.borderStyle = .none
        email.textColor = .white
        email.attributedPlaceholder = NSAttributedString(string: "電子信箱", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)])
        email.layer.addSublayer(bottomLine)
    }
    
    func customConfirmPasswordTestField() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: password.frame.height-2, width: confirmPassword.frame.width, height: 1)
        
        bottomLine.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        
        confirmPassword.borderStyle = .none
        confirmPassword.textColor = .white
        confirmPassword.attributedPlaceholder = NSAttributedString(string: "確認密碼", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)])
        confirmPassword.layer.addSublayer(bottomLine)
    }
}
