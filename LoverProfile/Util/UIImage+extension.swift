//
//  UIImage+extension.swift
//  LoverProfile
//
//  Created by 笹野駿 on 2019/06/17.
//  Copyright © 2019 笹野駿. All rights reserved.
//

import UIKit

extension UIImageView {
    // DocumentディレクトリのfileURLを取得
    static func getDocumentsURL() -> URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        return documentsURL
    }

    // ディレクトリのパスにファイル名をつなげてファイルのフルパスを作る
    static func fileInDocumentsDirectory(filename: String) -> URL {
        let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let fileURL = URL(fileURLWithPath: filePath).appendingPathComponent(filename)
        return fileURL
    }
}
