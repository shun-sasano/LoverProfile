//
//  Profile.swift
//  LoverProfile
//
//  Created by 笹野駿 on 2019/04/10.
//  Copyright © 2019 笹野駿. All rights reserved.
//

import Foundation
import RealmSwift

class Profile: Object {
    
    convenience init(name: String, items: List<ProfileItem>?) {
        self.init()
        self.name = name
        self.items = items ?? List<ProfileItem>()
    }
    @objc dynamic var id = 0
    @objc dynamic var name: String = ""
    @objc dynamic var startDate: Date?
    @objc dynamic var iconImagePath: String?
    @objc dynamic var backgroundImagePath: String?
    var items: List<ProfileItem> = List<ProfileItem>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
