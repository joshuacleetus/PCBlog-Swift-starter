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
        
        print (Feed.getFeed() ?? "nothing")
        
        let urlString = "https://www.personalcapital.com/blog/wp-content/uploads/2021/12/year-end-checklist-small-business-owners-400x222.png"
        self.imageDownloadService.downloadFromURL(url: urlString, success: { image in
            print("Got the image size: \(image.size)")
        }, failure: { errorText in
            print(errorText)
        })
        self.view.backgroundColor = .cyan
    }


}

