//
//  ImageDownloadService.swift
//  PCBlog-Swift
//
//  Created by Hoan Tran on 8/25/22.
//

import Foundation
import UIKit

class ImageDownloadService {
    private var cache = NSCache<NSString, UIImage>()
    
    public func downloadFromURL(url: String, success: @escaping (UIImage)->(), failure: @escaping (String)->())->() {
        if let cachedImage = self.cache .object(forKey: url as NSString) {
            success(cachedImage)
            return
        }
        
        RestService.shared.getURL(url: url) { data in
            if let image = UIImage(data: data) {
                success(image)
            } else {
                failure("Can not create image")
            }
        } failure: { errorText in
            print(errorText)
        }
    }
}
