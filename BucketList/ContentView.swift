//
//  ContentView.swift
//  BucketList
//
//  Created by Rob Ranf on 1/26/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var locations = [PinnedLocation]()
    @State private var selectedPlace: PinnedLocation?
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 35, longitude: 139),
            span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
        )
    )
    
    var body: some View {
        MapReader { proxy in
            Map(initialPosition: startPosition) {
                ForEach(locations) { location in
                    Annotation(location.name, coordinate: location.coordinate) {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundStyle(.red)
                            .frame(width: 44, height: 44)
                            .background(.white)
                            .clipShape(.circle)
                            .onLongPressGesture {
                                selectedPlace = location
                            }
                    }
                }
            }
            // Be careful not to overuse tap gestures as they are problematic with screen
            // readers. Instead, use buttons or other built-in controls. In this case,
            // a tap gesture must be used as that's the only way to accommodate a
            // user tapping on the map.
            .onTapGesture { position in
                if let coordinate = proxy.convert(position, from: .local) {
                    let newLocation = PinnedLocation(id: UUID(), name: "New Location",
                                               description: "", latitude: coordinate.latitude,
                                               longitude: coordinate.longitude)
                    locations.append(newLocation)
                }
            }
            .sheet(item: $selectedPlace) { place in
                Text(place.name)
                
                EditView(location: place) { newLocation in
                    if let index = locations.firstIndex(of: place) {
                        locations[index] = newLocation
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
