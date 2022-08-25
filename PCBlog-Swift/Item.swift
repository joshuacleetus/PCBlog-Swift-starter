//
//  Item.swift
//  PCBlog-Swift
//
//  Created by Hoan Tran on 8/22/22.
//

import Foundation

struct Item: Codable {
    let id: String
    let url: String
    let category: String
    let categories: [String]
    let title: String
    let encoded_title: String
    let featured_image: String
    let summary: String
    let insight_summary: String
    let author: [String:String]
    let authors: [String]
    let tags: [String]
}
