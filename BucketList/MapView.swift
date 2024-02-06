//
//  MapView.swift
//  BucketList
//
//  Created by Rob Ranf on 2/5/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    
    let locations = [
        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]
    
    var body: some View {
        Text("Here's a Map")
        MapReader { proxy in
            Map(position: $position, interactionModes: [.pan, .rotate, .zoom]) {
                ForEach(locations) { location  in
                    Marker(location.name, coordinate: location.coordinate)
    //                Annotation(location.name, coordinate: location.coordinate) {
    //                    Text(location.name)
    //                        .font(.headline)
    //                        .padding()
    //                        .background(.blue)
    //                        .foregroundStyle(.white)
    //                        .clipShape(.capsule)
    //                }
    //                .annotationTitles(.hidden)
                }
            }
            .onTapGesture { position in
                if let coordinate = proxy.convert(position, from: .local) {
                    print(coordinate)
                }
            }
            .onMapCameraChange { context in
                print(context.region)
            }
            .mapStyle(.hybrid(elevation: .realistic))
        }


        HStack(spacing: 50) {
            Button("Paris") {
                position = MapCameraPosition.region(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522), 
                        span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                        
                    )
                )
            }
            Button("Tokyo") {
                position = MapCameraPosition.region(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: 35.6897, longitude: 139.6922),
                        span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                        
                    )
                )
            }
        }
    }
}

struct Location: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

#Preview {
    MapView()
}
