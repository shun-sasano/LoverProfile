//
//  Event.swift
//  LoverProfile
//
//  Created by 笹野駿 on 2019/05/25.
//  Copyright © 2019 笹野駿. All rights reserved.
//

import Foundation
import RealmSwift

class Event: Object {
    @objc dynamic var id: String = NSUUID().uuidString
    @objc dynamic var startDate: Date = Date()
    @objc dynamic var finishDate: Date = Date()
    @objc dynamic var title: String = ""
    @objc dynamic var markColor: String = "#ffffff"
    @objc dynamic private var frequencyTypeString: String = FrequencyType.theDay.rawValue

    override static func primaryKey() -> String? {
        return "id"
    }
    
    var frequencyType: FrequencyType {
        get { // frequencyTypeStringはprivateなので初期値を設定している時点でnilになることはないが、privateを変更されることを考えると！はよくない。
            return FrequencyType(rawValue: frequencyTypeString)!
        }
        set {
            frequencyTypeString = newValue.rawValue
        }
    }
    
    enum FrequencyType: String, CaseIterable {
        case theDay     = "その日だけ"
        case everyWeek  = "毎週"
        case everyMonth = "毎月"
        case everyYear  = "毎年"
        
        var number: Int {
            switch self {
            case .theDay:
                return 0
            case .everyWeek:
                return 1
            case .everyMonth:
                return 2
            case .everyYear:
                return 3
            }
        }
    }
    
    func isMark(date: Date) -> Bool {
        guard date >= startDate else { return false }
        
        switch self.frequencyType {
        case .theDay:
            if date >= startDate && date <= finishDate {
                return true
            }
            return false
        case .everyWeek:
            if date.weekday < startDate.weekday {
                if finishDate.weekday > date.weekday && finishDate.weekday < startDate.weekday {
                    return true
                }
            } else if date.weekday > startDate.weekday {
                if finishDate.weekday >= date.weekday || startDate >= finishDate {
                    return true
                }
            } else if date.weekday == startDate.weekday ||
                date.weekday == finishDate.weekday {
                return true
            }
            return false
        case .everyMonth:
            if startDate.day < finishDate.day {
                if startDate.day <= date.day && finishDate.day >= date.day {
                    return true
                }
            } else {
                if startDate.day <= date.day && 31 >= date.day ||
                    finishDate.day >= date.day {
                    return true
                }
            }
            return false
        case .everyYear:
            // 年をまたぐ
            if startDate.month > finishDate.month {
                if startDate.month <= date.month && date.month <= 12 {
                    if startDate.day <= date.day {
                        return true
                    }
                    return false
                }
                if finishDate.month >= date.month {
                    if finishDate.day >= date.day {
                        return true
                    }
                    return false
                }
            } else {
                if startDate.month <= date.month && finishDate.month >= date.month {
                    if startDate.day <= date.day || finishDate.day >= date.day {
                        return true
                    }
                }
            }
            return false
        }
    }
}
