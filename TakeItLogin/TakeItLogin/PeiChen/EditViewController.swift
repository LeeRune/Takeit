//
//  EditViewController.swift
//  Tackit
//
//  Created by 傅培禎 on 2021/2/2.
//

import UIKit

class EditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UINavigationBarDelegate {

//        var setImageToImage1: ((UIImage) -> Void)?
//        var setImageToTakeitVC: ((UIImage) -> Void)?
//        var setImageToPickImageVController: ((UIImage) -> Void)?
        @IBOutlet weak var pickImage: UIImageView!
    @IBAction func passWordChange(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var newVC: UIViewController!
        newVC = (storyboard.instantiateViewController(withIdentifier: "hhh") )
        self.navigationController?.pushViewController(newVC, animated: true)
        
    }
    override func viewDidLoad() {
            super.viewDidLoad()

            
        }
    
    override func viewWillAppear(_ animated: Bool) {
        let userDefaults = UserDefaults.standard
        if let pickedImage = userDefaults.data(forKey: "pickedImage") {
            if let image = UIImage(data: pickedImage) {
                pickImage?.image = image
            }
        }
    }
        
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.identifier == "toChangeImage" {
//                if let destination = segue.destination as? PickImageVController {
//                    destination.setImageToImage1 = { [weak self] image in
//                        self?.pickImage?.image = image
//                        self?.setImageToTakeitVC?(image)
                        
                        
//                    }
//
//
//                }
//            }
//        }
//     func prepare1(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toChangeImage" {
//            if let destination = segue.destination as? TakeitViewController {
//                destination.setImageToImage1 = { [weak self] image in
//                    self?.pickImage?.image = image
//                    self?.setImageToPickImageVController?(image)
//
//
//                }
//
//
//            }
//        }
//    }
        
}
