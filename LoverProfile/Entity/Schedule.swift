//
//  Schedule.swift
//  LoverProfile
//
//  Created by 笹野駿 on 2019/04/17.
//  Copyright © 2019 笹野駿. All rights reserved.
//

import Foundation
import RealmSwift

class Schedule: Object {
    @objc dynamic var date: Date = Date()
    @objc dynamic var content: String = ""
    @objc dynamic var isDate: Bool = false
    var events: List<Event> = List<Event>()
}
