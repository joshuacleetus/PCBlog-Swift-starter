//
//  ArticleDecorationView.swift
//  PCBlog-Swift
//
//  Created by Joshua Cleetus on 7/30/23.
//

import UIKit

class ItemDecorationView: UICollectionReusableView {
    static let reuseIdentifier = "ItemDecorationView"

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
