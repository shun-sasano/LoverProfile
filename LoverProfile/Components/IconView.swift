//
//  IconView.swift
//  LoverProfile
//
//  Created by 笹野駿 on 2019/05/03.
//  Copyright © 2019 笹野駿. All rights reserved.
//

import Foundation
import UIKit

class IconView: UIView {
    var imageView: UIImageView?
    var noImageLabel: UILabel?
    
    
    override func draw(_ rect: CGRect) {
        if imageView?.image == nil || imageView?.image == UIImage() {
            noImageLabel?.isHidden = false
        } else {
            noImageLabel?.isHidden = true
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        let imageView = UIImageView()
        self.imageView = imageView
//        imageView.layer.cornerRadius = 75
//        imageView.layer.masksToBounds = true
//        imageView.layer.borderWidth = 3
//        imageView.layer.borderColor = UIColor.ex.mainPink.cgColor
        imageView.contentMode = .scaleAspectFill
        
        addSubview(imageView)
        imageView.snp.makeConstraints{ (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        let noImageLabel = UILabel()
        self.noImageLabel = noImageLabel
        noImageLabel.text = "アイコンが\n設定されていません"
        noImageLabel.textColor = UIColor.ex.labelGrey
        noImageLabel.textAlignment = .center
        noImageLabel.numberOfLines = 0
        noImageLabel.sizeToFit()
        addSubview(noImageLabel)
        noImageLabel.snp.makeConstraints{ (make) in
            make.size.equalTo(noImageLabel.frame.size)
            make.center.equalToSuperview()
        }
    }
}
