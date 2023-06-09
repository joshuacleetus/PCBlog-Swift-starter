//
//  Feed.swift
//  PCBlog-Swift
//
//  Created by Hoan Tran on 8/22/22.
//

import Foundation

// https://www.empower.com/api/blog/json

struct Feed: Codable {
    let title: String
    let items: [Item]
    
    static private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    static private func parse(jsonData: Data) -> Feed? {
        do {
            let decodedData = try JSONDecoder().decode(Feed.self,
                                                       from: jsonData)
            return decodedData
        } catch {
            print("Decode error: \(error)")
            return nil
        }
    }
    
    static public func getFeed() -> Feed? {
        var res:Feed? = nil
        
        if let localData = self.readLocalFile(forName: "feed") {
            if let feed = self.parse(jsonData: localData) {
                res = feed
            }
        }
        return res
    }
    
}

