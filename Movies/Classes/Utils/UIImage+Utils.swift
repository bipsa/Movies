//
//  UIImage+Utils.swift
//  Movies
//
//  Created by Sebastian Romero on 12/09/18.
//  Copyright © 2018 Maachi. All rights reserved.
//

import UIKit

extension UIImage {
    
    convenience init?(cache key: String) {
        let url = URL(fileURLWithPath: key)
        let path = (NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(url.lastPathComponent)
        if FileManager.default.fileExists(atPath: path){
            self.init(contentsOfFile: path)!
        } else {
            return nil
        }
    }
    
    
    func cache(key:String){
        let url = URL(fileURLWithPath: key)
        let path = (NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(url.lastPathComponent)
        let imageData = UIImagePNGRepresentation(self)
        FileManager.default.createFile(atPath: path as String, contents: imageData, attributes: nil)
    }

    
}
