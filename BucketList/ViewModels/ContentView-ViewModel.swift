//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Rob Ranf on 2/16/24.
//

import Foundation
import MapKit
import CoreLocation
import LocalAuthentication

extension ContentView {
    @Observable
    class ViewModel {
        var isUnlocked = false
        private(set) var locations: [PinnedLocation]
        var selectedPlace: PinnedLocation?
        
        var authenticationError = "Unnkown error"
        var isShowingAuthenticationError = false
        
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
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            // The reason string here is for touch id and the
            // reason string in Info.plist is for Face ID
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                       localizedReason: reason) { success, authenticationError in
                    
                    if success {
                        self.isUnlocked = true
                    } else {
                        self.authenticationError = 
                        "There was a problem authenticating you. Please try again."
                        self.isShowingAuthenticationError = true
                    }
                }
            } else {
                // No biometrics
                authenticationError =
                "Sorry, your device does not support biometric authentication."
                isShowingAuthenticationError = true
            }
        }
    }
}
