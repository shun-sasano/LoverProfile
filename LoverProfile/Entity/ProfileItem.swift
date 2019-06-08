//
//  ProfileItem.swift
//  LoverProfile
//
//  Created by 笹野駿 on 2019/04/10.
//  Copyright © 2019 笹野駿. All rights reserved.
//

import Foundation
import RealmSwift

class ProfileItem: Object {
    
    convenience init(title: String, content: String) {
        self.init()
        self.title = title
        self.content = content
    }
    @objc dynamic var title: String = ""
    @objc dynamic var content: String = ""
}
