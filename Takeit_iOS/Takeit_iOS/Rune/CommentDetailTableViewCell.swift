//
//  CommentDetailTableViewCell.swift
//  Takeit_iOS
//
//  Created by 李易潤 on 2021/2/23.
//

import UIKit

class CommentDetailTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
