//
//  ViewController.swift
//  PCBlog-Swift
//
//  Created by Hoan Tran on 8/22/22.
//

import UIKit

class ViewController: UIViewController {
    private lazy var imageDownloadService = ImageDownloadService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Replace everything with your own code
        self.view.backgroundColor = .cyan

        if let feed = Feed.getFeed() {
            if let imageURL = feed.items.first?.featured_image {
                self.imageDownloadService.downloadFromURL(url: imageURL, success: { image in
                    print("Got the image size: \(image.size)")
                    print("The world is good!")
                }, failure: { errorText in
                    print(errorText)
                })
            } else {
                print ("Err: Can not get the URL string")
            }
        } else {
            print ("Err: Can not get the feed")
        }
    }
}

