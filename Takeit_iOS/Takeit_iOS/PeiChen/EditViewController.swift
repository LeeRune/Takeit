//
//  EditViewController.swift
//  Tackit
//
//  Created by 傅培禎 on 2021/2/2.
//

import UIKit

class EditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var pickView: [UIImageView]!
    
    @IBAction func pickButton(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        /* 將UIImagePickerControllerDelegate、UINavigationControllerDelegate物件指派給UIImagePickerController */
        imagePicker.delegate = self
        /* 照片來源為相簿 */
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    let imagePicker = UIImagePickerController()
    /* 將UIImagePickerControllerDelegate、UINavigationControllerDelegate物件指派給UIImagePickerController */
    imagePicker.delegate = self
    /* 照片來源為相簿 */
    imagePicker.sourceType = .photoLibrary
    present(imagePicker, animated: true, completion: nil)
    
    /* 挑選照片過程中如果按了Cancel，關閉挑選畫面 */
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    

    

}
