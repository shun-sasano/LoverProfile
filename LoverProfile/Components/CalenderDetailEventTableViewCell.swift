//
//  CalenderDetailEventTableViewCell.swift
//  LoverProfile
//
//  Created by 笹野駿 on 2019/06/08.
//  Copyright © 2019 笹野駿. All rights reserved.
//

import UIKit

class CalenderDetailEventTableViewCell: UITableViewCell {

    var titleLabel: UILabel!
//    @IBOutlet weak var titleLabel: UILabel!
        var colorMarkView: UIView!
//    @IBOutlet weak var colorMarkView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setupAutolayout()
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        let titleLabel = UILabel()
        self.titleLabel = titleLabel
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = UIColor.ex.black87
        contentView.addSubview(titleLabel)
        
        let colorMarkView = UIView()
        self.colorMarkView = colorMarkView
        colorMarkView.layer.cornerRadius = 10
        colorMarkView.layer.masksToBounds = true
        contentView.addSubview(colorMarkView)
    }

    func setupAutolayout() {
        colorMarkView.snp.makeConstraints{ (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: 20,height: 20))
        }
        
        titleLabel.snp.makeConstraints{ (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(colorMarkView.snp.right).offset(8)
            make.right.equalToSuperview()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
