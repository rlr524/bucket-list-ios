//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Rob Ranf on 2/16/24.
//

import Foundation
import MapKit
import CoreLocation

extension ContentView {
    @Observable
    class ViewModel {
        private(set) var locations: [PinnedLocation]
        var selectedPlace: PinnedLocation?
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([PinnedLocation].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = PinnedLocation(id: UUID(), name: "New Location", description: "",
                                             latitude: point.latitude, longitude: point.longitude)
            locations.append(newLocation)
            
            save()
        }
        
        func updateLocation(location: PinnedLocation) {
            guard let selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
            }
            
            save()
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                // The .completeFileProtection variable stores the file with encryption.
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
    }
}
