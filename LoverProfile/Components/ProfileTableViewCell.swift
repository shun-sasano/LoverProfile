//
//  ProfileTableViewCell.swift
//  LoverProfile
//
//  Created by 笹野駿 on 2019/04/10.
//  Copyright © 2019 笹野駿. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentLabel.numberOfLines = 1
        let border = CALayer()
        border.frame = CGRect(x: 10, y: 79, width: Device.screenWidth() - 10, height: 1)
        border.backgroundColor = UIColor.ex.lightGrey.cgColor
        self.layer.addSublayer(border)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
