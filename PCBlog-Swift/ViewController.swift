//
//  ViewController.swift
//  PCBlog-Swift
//
//  Created by Hoan Tran on 8/22/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print (Feed.getFeed() ?? "nothing")
        
        self.view.backgroundColor = .cyan
    }


}

