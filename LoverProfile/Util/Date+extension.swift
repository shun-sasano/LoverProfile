//
//  Date+extension.swift
//  LoverProfile
//
//  Created by 笹野駿 on 2019/04/17.
//  Copyright © 2019 笹野駿. All rights reserved.
//

import Foundation

extension Date {
    
    func toStringWithCurrentLocale() -> String {
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        formatter.dateFormat = "yyyy年MM月dd日"
        
        return formatter.string(from: self)
    }
    
    func removeYearAndMonth() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        formatter.dateFormat = "dd日"
        
        return formatter.string(from: self)
    }
    
}
