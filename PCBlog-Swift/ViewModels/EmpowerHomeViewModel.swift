//
//  EmpowerHomeViewModel.swift
//  PCBlog-Swift
//
//  Created by Joshua Cleetus on 7/30/23.
//

import UIKit

class EmpowerHomeViewModel {
    var feedTitle: String = ""
    var items: [Item] = []
    private let imageService: ImageDownloadService // A service to fetch image from the server

    init(imageService: ImageDownloadService) {
        self.imageService = imageService
    }

    func fetchFeedItems(completion: @escaping ([Item]) -> Void) {
        if let feed = Feed.getFeed() {
            self.feedTitle = feed.title
            self.items = feed.items
            completion(self.items)
        } else {
            print ("Err: Can not get the feed")
        }
    }
        
    func fetchImage(for item: Item, completion: @escaping (UIImage) -> Void) {
        let imageURL = item.featured_image
        self.imageService.downloadFromURL(url: imageURL, success: { image in
            completion(image)
            print("Got the image size: \(image.size)")
            print("The world is good!")
        }, failure: { errorText in
            print(errorText)
        })
    }

    func item(at index: Int) -> Item {
        return items[index]
    }
}
