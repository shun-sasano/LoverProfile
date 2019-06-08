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
    
    var leftEventLabel: UILabel?
    var centerEventLabel: UILabel?
    var rightEventLabel: UILabel?
    
    var eventArray: [Event] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupAutolayout()
    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
//        layer.cornerRadius = 3
//        layer.borderWidth = 1
//        layer.borderColor = UIColor.ex.lightGrey.cgColor
        
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
        
        let leftEventLabel = UILabel()
        self.leftEventLabel = leftEventLabel
        leftEventLabel.layer.cornerRadius = 5
        leftEventLabel.layer.masksToBounds = true
        leftEventLabel.isHidden = true
        contentView.addSubview(leftEventLabel)
        
        let rightEventLabel = UILabel()
        self.rightEventLabel = rightEventLabel
        rightEventLabel.layer.cornerRadius = 5
        rightEventLabel.layer.masksToBounds = true
        rightEventLabel.isHidden = true
        contentView.addSubview(rightEventLabel)
        
        let centerEventLabel = UILabel()
        self.centerEventLabel = centerEventLabel
        centerEventLabel.layer.cornerRadius = 5
        centerEventLabel.layer.masksToBounds = true
        centerEventLabel.isHidden = true
        contentView.addSubview(centerEventLabel)
    }
    
    func setupAutolayout() {
        leftImageView?.snp.makeConstraints{ (make) in
            make.size.equalTo(CGSize(width: 13, height: 13))
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
        
        rightImageView?.snp.makeConstraints{ (make) in
            make.size.equalTo(CGSize(width: 13, height: 13))
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
        }
        
        leftEventLabel?.snp.makeConstraints{ (make) in
            make.bottom.equalToSuperview().offset(-5)
            make.left.equalToSuperview().offset(10)
            make.size.equalTo(CGSize(width: 10, height: 10))
        }
        
        centerEventLabel?.snp.makeConstraints{ (make) in
            make.bottom.equalToSuperview().offset(-5)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 10, height: 10))
        }
        
        rightEventLabel?.snp.makeConstraints{ (make) in
            make.bottom.equalToSuperview().offset(-5)
            make.right.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 10, height: 10))
        }
    }
    
    func displayEventMark() {
        var eventCount = 0
        for event in eventArray {
            eventCount += 1
            switch eventCount {
            case 1:
                leftEventLabel?.isHidden = false
                leftEventLabel?.backgroundColor = UIColor(code: event.markColor)
            case 2:
                centerEventLabel?.isHidden = false
                centerEventLabel?.backgroundColor = UIColor(code: event.markColor)
            case 3:
                rightEventLabel?.isHidden = false
                rightEventLabel?.backgroundColor = UIColor(code: event.markColor)
            default:
                return
            }
        }
    }
    
    func reset() {
        eventArray = []
        leftImageView?.image = nil
        rightImageView?.image = nil
        leftEventLabel?.isHidden = true
        centerEventLabel?.isHidden = true
        rightEventLabel?.isHidden = true
        leftEventLabel?.backgroundColor = nil
        centerEventLabel?.backgroundColor = nil
        rightEventLabel?.backgroundColor = nil
    }

}
