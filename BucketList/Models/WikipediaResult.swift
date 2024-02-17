//
//  Result.swift
//  BucketList
//
//  Created by Rob Ranf on 2/16/24.
//

import Foundation

struct WikipediaResult: Codable {
    let query: WikipediaQuery
}

struct WikipediaQuery: Codable {
    let pages: [Int: WikipediaPage]
}

struct WikipediaPage: Codable, Comparable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    
    static func <(lhs: WikipediaPage, rhs: WikipediaPage) -> Bool {
        lhs.title < rhs.title
    }
    
    var description: String {
        terms?["description"]?.first ?? "No further information"
    }
}
