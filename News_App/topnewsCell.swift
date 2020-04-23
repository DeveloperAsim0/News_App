//
//  topnewsCell.swift
//  News_App
//
//  Created by Mihir Vyas on 22/04/20.
//  Copyright © 2020 Mihir Vyas. All rights reserved.
//

import UIKit

class topnewsCell: UITableViewCell {

    @IBOutlet weak var titletext: UITextView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var newsImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
