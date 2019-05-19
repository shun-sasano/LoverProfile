//
//  OriginCalendarViewCell.swift
//  LoverProfile
//
//  Created by 笹野駿 on 2019/05/09.
//  Copyright © 2019 笹野駿. All rights reserved.
//

import UIKit
import FSCalendar

class OriginCalendarViewCell: FSCalendarCell {
    
    var leftImageView: UIImageView?
    var rightImageView: UIImageView?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupAutolayout()
    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        let leftImageView = UIImageView()
        self.leftImageView = leftImageView
        leftImageView.contentMode = .scaleAspectFit
        leftImageView.layer.masksToBounds = true
        contentView.addSubview(leftImageView)
        
        let rightImageView = UIImageView()
        self.rightImageView = rightImageView
        rightImageView.contentMode = .scaleAspectFit
        rightImageView.layer.masksToBounds = true
        contentView.addSubview(rightImageView)
    }
    
    func setupAutolayout() {
        leftImageView?.snp.makeConstraints{ (make) in
            make.size.equalTo(CGSize(width: 10, height: 10))
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
        }
        
        rightImageView?.snp.makeConstraints{ (make) in
            make.size.equalTo(CGSize(width: 10, height: 10))
            make.bottom.equalToSuperview().offset(-10)
            make.right.equalToSuperview().offset(-10)
        }
    }

}
