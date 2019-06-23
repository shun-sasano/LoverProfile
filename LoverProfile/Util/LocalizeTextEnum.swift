//
//  LocalizeTextEnum.swift
//  LoverProfile
//
//  Created by 笹野駿 on 2019/06/22.
//  Copyright © 2019 笹野駿. All rights reserved.
//

import Foundation

enum LSEnum {
    case save
    case configError
    case configErrorWeek
    case configErrorMonth
    case configErrorYear
    case yes
    case eventTitle
    case title
    case duration
    case frequency
    case markColor
    case startDate
    case finishDate
    case content
    case setDate
    case removeDate
    case delete
    case day
    case month
    case year
    case durationOfAssociate
    

    var text: String {
        var _text: String
        switch self {
        case .save:
            _text = "save"
        case .configError:
            _text = "configError"
        case .configErrorWeek:
            _text = "configErrorWeek"
        case .configErrorMonth:
            _text = "configErrorMonth"
        case .configErrorYear:
            _text = "configErrorMonth"
        case .yes:
            _text = "yes"
        case .eventTitle:
            _text = "eventTitle"
        case .title:
            _text = "title"
        case .duration:
            _text = "duration"
        case .frequency:
            _text = "frequency"
        case .markColor:
            _text = "markColor"
        case .startDate:
            _text = "markColor"
        case .finishDate:
            _text = "finishDate"
        case .content:
            _text = "content"
        case .setDate:
            _text = "setDate"
        case .removeDate:
            _text = "removeDate"
        case .delete:
            _text = "delete"
        case .day:
            _text = "day"
        case .month:
            _text = "month"
        case .year:
            _text = "year"
        case .durationOfAssociate:
            _text = "durationOfAssociate"
        }
        return NSLocalizedString(_text, comment: "")
    }
}
