//
//  UITextField+Extension.swift
//  LoverProfile
//
//  Created by 笹野駿 on 2019/05/01.
//  Copyright © 2019 笹野駿. All rights reserved.
//

import UIKit

extension UITextField {
    func addBorderBottom(height: CGFloat, color: UIColor) {
        self.borderStyle = .none
        let border = CALayer()
        border.frame = CGRect(x: 0, y: 40, width: Device.screenWidth() - 60, height: height)
        border.backgroundColor = color.cgColor
        self.layer.addSublayer(border)
    }
}

extension UILabel {
    func addBorderLeft(width: CGFloat, color: UIColor) {
        // autolayout設定後じゃないと効かない気がする
        let border = CALayer()
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.height)
        border.backgroundColor = color.cgColor
        self.layer.addSublayer(border)
    }
}
