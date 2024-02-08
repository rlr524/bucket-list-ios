//
//  Location.swift
//  BucketList
//
//  Created by Rob Ranf on 2/7/24.
//

import Foundation

struct Location: Codable, Equatable, Identifiable {
    let id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
}
