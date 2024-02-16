//
//  Location.swift
//  BucketList
//
//  Created by Rob Ranf on 2/7/24.
//

import Foundation
import MapKit

struct Location: Codable, Equatable, Identifiable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    // Example for preview, if DEBUG macro suppresses this from App Store release.
    #if DEBUG
    static let example = Location(id: UUID(),
                                  name: "Imperial Palace",
                                  description: "The residence of the Emperor since 1869",
                                  latitude: 35.6895, longitude: 139.7521)
    #endif
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
