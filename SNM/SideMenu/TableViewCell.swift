//
//  TableViewCell.swift
//  SNM
//
//  Created by Administrator on 07/09/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var iconImg: UIImageView!
    
    @IBOutlet weak var iconName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
