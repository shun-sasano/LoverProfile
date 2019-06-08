//
//  CaseIterable+extension.swift
//  LoverProfile
//
//  Created by 笹野駿 on 2019/05/27.
//  Copyright © 2019 笹野駿. All rights reserved.
//

import Foundation
extension CaseIterable where Self: RawRepresentable {
    
    static var allValues: [RawValue] {
        return allCases.map { $0.rawValue }
    }
}
