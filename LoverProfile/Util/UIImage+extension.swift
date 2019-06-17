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
    
//    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as NSURL
    //        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    //        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
    


    // ディレクトリのパスにファイル名をつなげてファイルのフルパスを作る
    static func fileInDocumentsDirectory(filename: String) -> URL {
        let fileURL = getDocumentsURL().appendingPathComponent(filename)
        return fileURL
    }
}
