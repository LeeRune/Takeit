//
//  TakeitViewController.swift
//  Tackit
//
//  Created by 傅培禎 on 2021/2/2.
//

import UIKit

class TakeitViewController: UIViewController,UITableViewDataSource {
    
//    var setImageToEditViewController: ((UIImage) -> Void)?
//    var setImageToTakeitVC: ((UIImage) -> Void)?
//    var setImageToImage1: ((UIImage) -> Void)?
    @IBOutlet weak var phoneImageView: UIImageView!
    
        
        // UIImagePickerController是個可讓user挑選圖庫內照片的view controller
//        let imagePickerController = UIImagePickerController()
//        imagePickerController.sourceType = .photoLibrary
//        imagePickerController.delegate = self
//        present(imagePickerController, animated: true, completion: nil)
    
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
//        phoneImageView.image = selectedImage
//        dismiss(animated: true, completion: nil)
//    }
//    
//    
//        
//    /* 實作UIImagePickerControllerDelegate */
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        dismiss(animated: true, completion: nil)
//    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    
    
    @IBOutlet var containerViews: [UIView]!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "會員中心"
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let userDefaults = UserDefaults.standard
        if let pickedImage = userDefaults.data(forKey: "pickedImage") {
            if let image = UIImage(data: pickedImage) {
                phoneImageView.image = image
            }
        }
    }
    
    @IBAction func changeMovie(_ sender: UISegmentedControl) {
        containerViews.forEach {
            $0.isHidden = true
        }
        containerViews[sender.selectedSegmentIndex].isHidden = false
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toImage1" {
//            if let destination = segue.destination as? EditViewController {
//                destination.setImageToTakeitVC = { [weak self] image in
//                    self?.phoneImageView?.image = image
//
//
//
//
//
//                }
//            }
//            if segue.identifier == "toImage1" {
//                if let destination = segue.destination as? TakeitViewController {
//                    destination.setImageToImage1 = { [weak self] image in
//                        self?.phoneImageView?.image = image
//
//                    }
//                }
//            }
//        }
//
//        }
    
    
    
    @IBAction func unwindToPageB(segue: UIStoryboardSegue) {
            print("unwindToPageB...")
        }
    
    
//    func saveData() {
//        let userDefaults = UserDefaults.standard
//        /* 先將UIImage轉成Data方能存檔 */
//        if let image = phoneImageView.image?.jpegData(compressionQuality: 1.0) {
//            userDefaults.set(image, forKey: "image")
//        }
//
//    }
}

    
     
    
    

