//
//  EventTableViewCell.swift
//  LoverProfile
//
//  Created by 笹野駿 on 2019/05/25.
//  Copyright © 2019 笹野駿. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var colorMarkView: UIView!
    @IBOutlet weak var detailLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    func setupViews() {
        detailLabel.textColor = UIColor.ex.black54
        colorMarkView.layer.cornerRadius = colorMarkView.frame.height / 2
        colorMarkView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func reset() {
        colorMarkView.backgroundColor = UIColor.clear
    }
    
}
