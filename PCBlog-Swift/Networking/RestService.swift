//
//  RestService.swift
//  PCBlog-Swift
//
//  Created by Hoan Tran on 8/25/22.
//

import Foundation

/*
 ..............................................................................................
 Barebone impletation without unit testing
 Most likely, a full app would download specialized date such as images or videos.
 In that case, this service would expand to include those specific functions

 Timing out a GET request would be very useful
 when Internet connection is not possible.
 A timeout signal would alert the user that something is wrong with connectivity, and
 not with the application itself.

 A "Cancel" request would also be useful when the controller issuing the original request
 no longer cares about the result. Perhaps, placing all these requests in a queue would be useful.

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
