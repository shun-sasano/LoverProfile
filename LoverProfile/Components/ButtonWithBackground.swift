//
//  ButtonWithBackground.swift
//  LoverProfile
//
//  Created by 笹野駿 on 2019/05/04.
//  Copyright © 2019 笹野駿. All rights reserved.
//

import Foundation
import UIKit

class ButtonWithBackground: UIView {
    
    var backgroundImageView: UIImageView?
    var button: UIButton?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        setupAutolayout()
    }
    
    func setupViews() {
        let backgroundImageView = UIImageView()
        self.backgroundImageView = backgroundImageView
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.layer.masksToBounds = true
        addSubview(backgroundImageView)
        
        let button = UIButton()
        self.button = button
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.imageView?.contentMode = .scaleAspectFit
        addSubview(button)
    }
    
    func setupAutolayout() {
        backgroundImageView?.snp.makeConstraints{ (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        button?.snp.makeConstraints{ (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }

}
