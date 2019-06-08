//
//  AddItemButton.swift
//  LoverProfile
//
//  Created by 笹野駿 on 2019/05/01.
//  Copyright © 2019 笹野駿. All rights reserved.
//

import UIKit

class AddItemButton: UIButton {

    override func draw(_ rect: CGRect) {
         setup()
    }

//    init() {
//        super.init(frame: .zero)
//        setup()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func setup() {
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
        setImage(UIImage(named: "additembutton")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
    }
}
