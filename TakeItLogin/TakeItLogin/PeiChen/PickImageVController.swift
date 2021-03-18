//
//  PickImage.swift
//  Tackit
//
//  Created by 傅培禎 on 2021/3/10.
//

import UIKit

class PickImageVController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UINavigationBarDelegate {

//    var setImageToImage1: ((UIImage) -> Void)?
//    var setImageToTakeitVC: ((UIImage) -> Void)?
//    var setImageToPickImageVController: ((UIImage) -> Void)?
    @IBOutlet weak var pickImage: UIImageView?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PickImageVController - viewDidLoad()")

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let userDefaults = UserDefaults.standard
        if let pickedImage = userDefaults.data(forKey: "pickedImage") {
            if let image = UIImage(data: pickedImage) {
                pickImage?.image = image
            }
        }
    }

    
    @IBAction func pickButton(_ sender: UIButton) {

        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        /* 利用指定的key從info dictionary取出照片 */
        if let pickedImage = info[.originalImage] as? UIImage {
            pickImage?.image = pickedImage
            let userDefaults = UserDefaults.standard
            if let image = pickedImage.jpegData(compressionQuality: 1.0) {
                userDefaults.set(image, forKey: "pickedImage")
            }
//            setImageToImage1?(pickedImage)
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    /* 挑選照片過程中如果按了Cancel，關閉挑選畫面 */
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        print("PickImageVController - prepare()")
//        if segue.identifier == "toChangeImage" {
//            if let destination = segue.destination as? PickImageVController {
//                destination.setImageToImage1 = { [weak self] image in
//                    self?.pickImage?.image = image
//                    self?.setImageToTakeitVC?(image)
//                    
//                }
//            }
//        }
//    }
//    
//    
//    func prepare1(for segue: UIStoryboardSegue, sender: Any?) {
//       if segue.identifier == "toChangeImage" {
//           if let destination = segue.destination as? PickImageVController {
//               destination.setImageToImage1 = { [weak self] image in
//                   self?.pickImage?.image = image
//                   self?.setImageToPickImageVController?(image)
//
//
//               }
//
//
//           }
//       }
//   }
    
    
}
