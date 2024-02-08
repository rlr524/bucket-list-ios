//
//  ContentView.swift
//  BucketList
//
//  Created by Rob Ranf on 1/26/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var locations = [Location]()
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 47, longitude: -122),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    var body: some View {
        MapReader { proxy in
            Map(initialPosition: startPosition) {
                ForEach(locations) { location in
                    Marker(location.name, coordinate: CLLocationCoordinate2D(
                        latitude: location.latitude, longitude: location.longitude))
                }
            }
            // Be careful not to overuse tap gestures as they are problematic with screen
            // readers. Instead, use buttons or other built-in controls. In this case,
            // a tap gesture must be used as that's the only way to accommodate a
            // user tapping on the map.
            .onTapGesture { position in
                if let coordinate = proxy.convert(position, from: .local) {
                    let newLocation = Location(id: UUID(), name: "New Location",
                                               description: "", latitude: coordinate.latitude,
                                               longitude: coordinate.longitude)
                    locations.append(newLocation)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
