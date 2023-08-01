//
//  ArticleDetailViewController.swift
//  PCBlog-Swift
//
//  Created by Joshua Cleetus on 7/30/23.
//

import UIKit
import WebKit

class EmpowerItemDetailViewController: UIViewController {
    // MARK: - Properties

    private let webView = WKWebView()
    private let item: Item

    // MARK: - Initialization

    init(item: Item) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.uiDelegate = self
        setupNavigationBar()

        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        let htmlString = "<html><body><h1>\(item.title)</h1><p>\(item.content_html)</p></body></html>"
        webView.loadHTMLString(htmlString, baseURL: nil)
    }

    // MARK: - Navigation Bar Setup

    private func setupNavigationBar() {
        // Add a close button to the navigation bar for iPhone
        if UIDevice.current.userInterfaceIdiom == .phone {
            let closeButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeButtonTapped))
            navigationItem.rightBarButtonItem = closeButton
        }
    }

    @objc private func closeButtonTapped() {
        // Dismiss the modal view on iPhone when the close button is tapped
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - WKUIDelegate

extension EmpowerItemDetailViewController: WKUIDelegate {}

