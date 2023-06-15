//
//  RestService.swift
//  PCBlog-Swift
//
//  Created by Hoan Tran on 8/25/22.
//

import Foundation

/*
 ..............................................................................................
 Barebone impletation without unit testing, or abiblity to cancel a request.
 Most likely, a full app would download specialized date such as images or videos.
 In that case, this service would expand to include those specific functions

 This service is re-entrant. So multiple simultaneous requests are possible
 ..............................................................................................
 */
class RestService {
    static let shared = RestService()
    private init() { }

    public func getURL(url: String, success: @escaping (Data)->(), failure: @escaping (String)->())->() {
        let url = URL(string: url)
        
        guard let url = url else {
            failure("can not get URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                success(data)
            } else {
                failure("Can not download data")
            }
        }
        task.resume()
    }
}
