//
//  UIView+extension.swift
//  LoverProfile
//
//  Created by 笹野駿 on 2019/06/07.
//  Copyright © 2019 笹野駿. All rights reserved.
//

import Foundation
import UIKit

enum BorderPosition {
    case top
    case left
    case right
    case bottom
}

extension UIView {
    /// 特定の場所にborderをつける
    ///
    /// - Parameters:
    ///   - width: 線の幅
    ///   - color: 線の色
    ///   - position: 上下左右どこにborderをつけるか
    func addBorder(width: CGFloat, color: UIColor, position: BorderPosition) {
        
        let border = CALayer()
        
        switch position {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: width)
            border.backgroundColor = color.cgColor
            self.layer.addSublayer(border)
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.height)
            border.backgroundColor = color.cgColor
            self.layer.addSublayer(border)
        case .right:
            print(self.frame.width)
            
            border.frame = CGRect(x: self.frame.width - width, y: 0, width: width, height: self.frame.height)
            border.backgroundColor = color.cgColor
            self.layer.addSublayer(border)
        case .bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - width, width: self.frame.width, height: width)
            border.backgroundColor = color.cgColor
            self.layer.addSublayer(border)
        }
    }
    
    func addBorderFullWidth(width: CGFloat, color: UIColor, position: BorderPosition) {
        
        let border = CALayer()
        border.frame = CGRect(x: 0, y: 0, width: Device.screenWidth(), height: width)
        border.backgroundColor = color.cgColor
        self.layer.addSublayer(border)
    }
}
