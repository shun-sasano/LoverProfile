//
//  UIColor+extension.swift
//  LoverProfile
//
//  Created by 笹野駿 on 2019/04/30.
//  Copyright © 2019 笹野駿. All rights reserved.
//

import Foundation
import UIKit

struct Extension<Base> {
    let base: Base
    init (_ base: Base) {
        self.base = base
    }
}

protocol ExtensionCompatible {
    associatedtype Compatible
    static var ex: Extension<Compatible>.Type { get }
    var ex: Extension<Compatible> { get }
}

extension ExtensionCompatible {
    static var ex: Extension<Self>.Type {
        return Extension<Self>.self
    }
    
    var ex: Extension<Self> {
        return Extension(self)
    }
}

extension UIColor {
    convenience init(code: String) {
        var color: UInt32 = 0
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0
        if Scanner(string: code.replacingOccurrences(of: "#", with: "")).scanHexInt32(&color) {
            r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            g = CGFloat((color & 0x00FF00) >>  8) / 255.0
            b = CGFloat( color & 0x0000FF       ) / 255.0
        }
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return NSString(format:"#%06x", rgb) as String
    }
}

extension UIColor: ExtensionCompatible {}

extension Extension where Base: UIColor {
    
    static var mainPink: UIColor {
        return #colorLiteral(red: 1, green: 0.6177613735, blue: 0.6292107701, alpha: 1)
    }
    
    static var accent: UIColor {
        return #colorLiteral(red: 0.09019607843, green: 0.7450980392, blue: 0.7333333333, alpha: 1)
    }
    
    static var accent2: UIColor {
        return #colorLiteral(red: 0.03137254902, green: 0.4941176471, blue: 0.5450980392, alpha: 1)
    }
    
    static var fontBlack: UIColor {
        return #colorLiteral(red: 0.1215686275, green: 0.1215686275, blue: 0.1215686275, alpha: 1)
    }
    
    static var black87: UIColor {
        return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.87)
    }
    
    static var black54: UIColor {
        return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.54)
    }
    
    static var black26: UIColor {
        return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.26)
    }
    
    static var black12: UIColor {
        return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
    }
    
    static var black6: UIColor {
        return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.06)
    }
    
    static var labelGrey: UIColor {
        return #colorLiteral(red: 0.4572430849, green: 0.4814780951, blue: 0.4622520804, alpha: 1)
    }
    
    static var lightGrey: UIColor {
        return #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
    }
    
    static var framePink: UIColor {
        return #colorLiteral(red: 0.9450980392, green: 0.862745098, blue: 0.862745098, alpha: 1)
    }
}
