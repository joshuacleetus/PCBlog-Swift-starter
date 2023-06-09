//
//  Item.swift
//  PCBlog-Swift
//
//  Created by Hoan Tran on 8/22/22.
//

import Foundation

struct Item: Codable {
    let id: String
    let title: String
    let summary: String
    let url: String
    let content_html: String
    let author: [String:String]
    let date_published: String
    let featured_image: String
}
