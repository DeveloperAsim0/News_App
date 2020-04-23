//
//  mostnewsCell.swift
//  News_App
//
//  Created by Mihir Vyas on 22/04/20.
//  Copyright © 2020 Mihir Vyas. All rights reserved.
//

import UIKit

class mostnewsCell: UITableViewCell { 

    @IBOutlet weak var myview: UIView!
    @IBOutlet weak var newimage2: UIImageView!
    @IBOutlet weak var discription: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
