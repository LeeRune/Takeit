//
//  TableViewCell.swift
//  takeit_top
//
//  Created by Lee on 2021/2/25.
//

import UIKit

class TVCell: UITableViewCell {

    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var textViewCell: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView?.backgroundColor = .black
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
            
        // Configure the view for the selected state
    }

}
