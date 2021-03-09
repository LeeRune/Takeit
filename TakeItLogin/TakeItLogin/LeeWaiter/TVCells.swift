//
//  TVCells.swift
//  takeit_top
//
//  Created by Lee on 2021/3/8.
//

import UIKit

class TVCells: UITableViewCell {

    @IBOutlet weak var imageViewCell: UIImageView!
    
    
    @IBOutlet weak var textViewCell: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
