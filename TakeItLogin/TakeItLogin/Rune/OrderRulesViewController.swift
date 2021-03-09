//
//  OrderRulesViewController.swift
//  Takeit_iOS
//
//  Created by 李易潤 on 2021/2/22.
//

import UIKit

class OrderRulesViewController: UIViewController {

    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var agreeButton: UIButton!
    @IBOutlet weak var orderRulesTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        checkButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 30), forImageIn: .normal)
        self.checkButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        self.checkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
    }

    @IBAction func checkButton(_ sender: UIButton) {
        if sender.isSelected {
                    self.checkButton.isSelected = false // 對應到 UIControl.State.normal
            self.agreeButton.backgroundColor = UIColor.darkGray
            self.agreeButton.isEnabled = false
                } else {
                    self.checkButton.isSelected = true // 對應到 UIControl.State.selected
                    self.agreeButton.isEnabled = true
                    self.agreeButton.backgroundColor = UIColor.systemRed
                }
    }
    
    @IBAction func agreeButton(_ sender: Any) {
        performSegue(withIdentifier: "PaySegue", sender: 0)
    }
    
}
