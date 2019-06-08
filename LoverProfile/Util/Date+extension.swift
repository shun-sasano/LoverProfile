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
    
    func removeYear() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        formatter.dateFormat = "MM月dd日"
        
        return formatter.string(from: self)
    }
    
    static func differenceDay(date1: Date, date2: Date) -> Int {
        let dayInterval = (Calendar.current.dateComponents([.day], from: date1, to: date2)).day
        return dayInterval ?? 0
    }
    
    static func differenceMonth(date1: Date, date2: Date) -> Int {
        let monthInterval = (Calendar.current.dateComponents([.month], from: date1, to: date2)).month
        return monthInterval ?? 0
    }
    
    static func differenceYear(date1: Date, date2: Date) -> Int {
        let yearInterval = (Calendar.current.dateComponents([.year], from: date1, to: date2)).year
        return yearInterval ?? 0
    }
}

extension String {
    func toDateFromString() -> Date {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
//        formatter.dateStyle = .long
//        formatter.locale = Locale(identifier: "ja")
        formatter.dateFormat = "yyyy年MM月dd日"
        
        return formatter.date(from: self)!
    }
}
